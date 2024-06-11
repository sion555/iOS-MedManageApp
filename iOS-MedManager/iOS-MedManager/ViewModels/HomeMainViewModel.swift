//
//  HomeMainViewModel.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/10/24.
//

import Foundation
import Combine

class HomeMainViewModel: ObservableObject {
    @Published var totalPills: Int = 0
    @Published var morningPills: [Pills] = []
    @Published var afternoonPills: [Pills] = []
    @Published var eveningPills: [Pills] = []
    @Published var currentDate: String = ""
    @Published var progress: Double = 0.0
    @Published var showingDatePicker = false
    @Published var selectedDate = Date()
    @Published var alertMessage: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchPrescriptions()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        currentDate = dateFormatter.string(from: Date())
    }

    func fetchPrescriptions() {
        PillService.shared.fetchPrescriptions { [weak self] result in
            switch result {
            case .success(let prescriptions):
                DispatchQueue.main.async {
                    self?.totalPills = prescriptions.flatMap { $0.pills ?? [] }.count
                    self?.morningPills = prescriptions.flatMap { $0.pills ?? [] }.filter { $0.doseTime == "morning" }
                    self?.afternoonPills = prescriptions.flatMap { $0.pills ?? [] }.filter { $0.doseTime == "afternoon" }
                    self?.eveningPills = prescriptions.flatMap { $0.pills ?? [] }.filter { $0.doseTime == "evening" }
                    self?.updateProgress()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.alertMessage = error.localizedDescription
                    self?.showingAlert = true
                }
            }
        }
    }

    func togglePill(pill: Pills) {
        if let index = morningPills.firstIndex(where: { $0.id == pill.id }) {
            morningPills[index].isTaken.toggle()
        }
        if let index = afternoonPills.firstIndex(where: { $0.id == pill.id }) {
            afternoonPills[index].isTaken.toggle()
        }
        if let index = eveningPills.firstIndex(where: { $0.id == pill.id }) {
            eveningPills[index].isTaken.toggle()
        }
        updateProgress()
    }

    private func updateProgress() {
        let totalTaken = morningPills.filter { $0.isTaken }.count + afternoonPills.filter { $0.isTaken }.count + eveningPills.filter { $0.isTaken }.count
        let totalPillsCount = totalPills
        progress = Double(totalTaken) / Double(totalPillsCount)
    }
}





