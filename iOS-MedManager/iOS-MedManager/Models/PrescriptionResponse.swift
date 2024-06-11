//
//  PrescriptionResponse.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/9/24.
//

import Foundation


struct PrescriptionResponse: Codable {
    let success: Bool
    let prescriptions: [Prescriptions]?
    let message: String
}

struct PrescriptionIDResponse: Codable {
    let success: Bool
    let prescription: [Prescriptions]?
    let message: String
}

struct PillDoseTimeResponse: Codable {
    let success: Bool
    let pills: [Pills]?
    let message: String
}

struct Prescriptions: Codable {
    let prescriptionID: Int?
    let userID: String
    let hospitalName: String?
    let prescriptionStartDate: Date?
    let prescriptionEndDate: Date?
    let pills: [Pills]?
    let receipts: [Receipts]?
    
    enum CodingKeys: String, CodingKey {
        case prescriptionID
        case userID
        case hospitalName
        case prescriptionStartDate
        case prescriptionEndDate
        case pills = "Pills"
        case receipts = "Receipts"
    }
}

struct Receipts: Codable {
    let receiptID: Int?
    let prescriptionID: Int?
    let receiptNumber: String?
    let totalPillExpense: Double?
    let personalExpense: Double?
    let insuranceExpense: Double?
    let totalPayment: Double?
    let pharmacyName: String?
    let hospitalName: String?
}

struct Pills: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    let pillID: Int
    let pillName: String
    let pillImage: String?
    let pillDescription: String?
    let pillType: String?
    let storageMethod: String?
    let medicineEffect: String?
    let prescriptionID: Int
    let doseTime: String?
    let instruction: Instruction?
    var isTaken: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case pillID
        case pillName
        case pillImage
        case pillDescription
        case pillType
        case storageMethod
        case medicineEffect
        case prescriptionID
        case doseTime
        case instruction = "Instruction"
    }
    
    static func == (lhs: Pills, rhs: Pills) -> Bool {
        return lhs.pillID == rhs.pillID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(pillID)
    }
}

struct Instruction: Codable {
    let instructionID: Int
    let prescriptionID: Int
    let pillID: Int
    let instruction: String
}

