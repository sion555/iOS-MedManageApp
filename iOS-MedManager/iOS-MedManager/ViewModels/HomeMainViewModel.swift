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
    @Published var pills: [Pills] = []
    @Published var currentDate: String = ""
    @Published var doseTimes: [String] = ["아침", "점심", "저녁"]
    @Published var showingAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var progress: Double = 0.0
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        currentDate = dateFormatter.string(from: Date())
    }
    
    func fetchPrescriptions() {
        PillService.shared.fetchPrescriptions { [weak self] result in
            switch result {
                case .success(let prescriptions):
                    DispatchQueue.main.async {
                        self?.pills = prescriptions.flatMap { $0.pills ?? [] }
                        self?.totalPills = self?.pills.count ?? 0
                        self?.progress = Double(self?.pills.filter { $0.isTaken }.count ?? 0) / Double(self?.totalPills ?? 1)
                    }
                case .failure(let error):
                    
                    print(error.localizedDescription)
                    
                    debugPrint(error)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showingAlert = true
                    }
            }
        }
    }
}



