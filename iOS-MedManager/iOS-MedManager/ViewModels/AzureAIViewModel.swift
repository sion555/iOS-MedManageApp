//
//  AzureAIViewModel.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/5/24.
//

import SwiftUI
import Combine

//class AzureDocumentIntelligenceViewModel: ObservableObject {
//    @Published var result: String = ""
//    private let service = AzureDocumentIntelligenceService()
//    
//    func analyzeImage(imageData: Data) {
//        service.analyzeImage(imageData: imageData) { [weak self] result in
//            switch result {
//            case .success(let operationLocation):
//                print("Operation Location: \(operationLocation)") // 디버깅 출력 추가
//                self?.pollAnalyzeResult(operationLocation: operationLocation)
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self?.result = "Error: \(error.localizedDescription)"
//                    print("Error: \(error.localizedDescription)") // 디버깅 출력 추가
//                }
//            }
//        }
//    }
//    
//    private func pollAnalyzeResult(operationLocation: String) {
//        service.getAnalyzeResult(operationLocation: operationLocation) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let analyzeResult):
//                    if analyzeResult.status == "succeeded" {
//                        var resultString = "Analysis result:\n"
//                        if let documents = analyzeResult.analyzeResult?.documents {
//                            for document in documents {
//                                if let medicineField = document.fields.medicine {
//                                    for medicine in medicineField.valueArray {
//                                        let pillName = medicine.valueObject.pillName.content
//                                        let pillType = medicine.valueObject.pillType.content
//                                        let instruction = medicine.valueObject.instruction.content
//                                        resultString += "Pill Name: \(pillName) Pill Type: \(pillType) Instruction: \(instruction)\n"
//                                    }
//                                } else {
//                                    resultString += "No medicine field found in document.\n"
//                                }
//                            }
//                            for document in documents {
//                                if let receiptField = document.fields.receipt {
//                                    for receipt in receiptField.valueArray {
//                                        let patientName = receipt.valueObject.patientName.content
//                                        let hospitalName = receipt.valueObject.hospitalName.content
//                                        let outOfExpense = receipt.valueObject.outOfPocketExpenses.content
//                                        let pharmacyName = receipt.valueObject.pharmacyName.content
//                                        resultString += "Patient Name: \(patientName) Hospital Name: \(hospitalName)\n Out of Pocket Expenses: \(outOfExpense) Pharmacy Name: \(pharmacyName)"
//                                    }
//                                } else {
//                                    resultString += "No receipt field found in document.\n"
//                                }
//                            }
//                        }
//                        self?.result = resultString
//                        print(resultString) // 디버깅 출력 추가
//                        
//                    } else if analyzeResult.status == "running" {
//                        // 분석이 완료되지 않은 경우 일정 시간 후 다시 요청
//                        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//                            self?.pollAnalyzeResult(operationLocation: operationLocation)
//                        }
//                    } else {
//                        self?.result = "Analysis status: \(analyzeResult.status)"
//                        print("Analysis status: \(analyzeResult.status)")
//                    }
//                case .failure(let error):
//                    self?.result = "Error: \(error.localizedDescription)"
//                    print("Error: \(error.localizedDescription)") // 디버깅 출력 추가
//                }
//            }
//        }
//    }
//}


class AzureDocumentIntelligenceViewModel: ObservableObject {
    @Published var result: String = ""
    private let service = AzureDocumentIntelligenceService()
    
    func analyzeImage(imageData: Data) {
        service.analyzeImage(imageData: imageData) { [weak self] result in
            switch result {
            case .success(let operationLocation):
                print("Operation Location: \(operationLocation)") // 디버깅 출력 추가
                self?.pollAnalyzeResult(operationLocation: operationLocation)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.result = "Error: \(error.localizedDescription)"
                    print("Error: \(error.localizedDescription)") // 디버깅 출력 추가
                }
            }
        }
    }
    
    private func pollAnalyzeResult(operationLocation: String) {
        service.getAnalyzeResult(operationLocation: operationLocation) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let analyzeResult):
                    if analyzeResult.status == "succeeded" {
                        if let jsonData = try? JSONEncoder().encode(analyzeResult),
                           let jsonString = String(data: jsonData, encoding: .utf8) {
                            self?.result = jsonString
                        }
                    } else if analyzeResult.status == "running" {
                        // 분석이 완료되지 않은 경우 일정 시간 후 다시 요청
                        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                            self?.pollAnalyzeResult(operationLocation: operationLocation)
                        }
                    } else {
                        self?.result = "Analysis status: \(analyzeResult.status)"
                        print("Analysis status: \(analyzeResult.status)")
                    }
                case .failure(let error):
                    self?.result = "Error: \(error.localizedDescription)"
                    print("Error: \(error.localizedDescription)") // 디버깅 출력 추가
                }
            }
        }
    }
}







