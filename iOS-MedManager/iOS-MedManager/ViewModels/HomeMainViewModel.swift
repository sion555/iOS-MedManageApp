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
    @Published var showingAlert: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchPrescriptions(for: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        currentDate = dateFormatter.string(from: Date())
    }

    func fetchPrescriptions(for date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        PillService.shared.fetchPrescriptions(for: dateString) { [weak self] result in
            switch result {
            case .success(let prescriptions):
                DispatchQueue.main.async {
                    let pills = prescriptions.flatMap { $0.pills ?? [] }
                    self?.totalPills = pills.count
                    self?.morningPills = pills.filter { $0.morning }
                    self?.afternoonPills = pills.filter { $0.afternoon }
                    self?.eveningPills = pills.filter { $0.evening }
                    self?.updateProgress()
                    self?.currentDate = dateFormatter.string(from: date)
                }
            case .failure(let error):
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
        progress = Double(totalTaken) / Double(totalPills)
    }
}





