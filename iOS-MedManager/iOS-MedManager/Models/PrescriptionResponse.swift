// PrescriptionResponse.swift
// iOS-MedManager
// Created by 한범석 on 6/9/24.

import Foundation

// iOS2차프로젝트_YakTokTok_BE Postman 명세 참조 !! 하세요 !! - 범석

// YakTokDB-GetPrescription 의 응답 모델링!
struct PrescriptionResponse: Codable {
    let success: Bool
    let prescriptions: [Prescriptions]?
    let message: String
}

// YakTokDB-GetPrescription-PreID 의 응답 모델링!
struct PrescriptionIDResponse: Codable {
    let success: Bool
    let prescription: [Prescriptions]?
    let message: String
}

// YakTokDB-GetPills-DoseTime 의 응답 모델링!
struct PillDoseTimeResponse: Codable {
    let success: Bool
    let pills: [Pills]?
    let message: String
}

// YakTokDB-GetPrescription-targetDate 의 응답 모델링!
struct Prescriptions: Codable {
    let prescriptionID: Int
    let userID: String
    let hospitalName: String?
    let prescriptionStartDate: String
    let prescriptionEndDate: String
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

// YakTokDB-GetReceipt 응답 모델링!
struct Receipts: Codable {
    let receiptID: Int
    let prescriptionID: Int
    let receiptNumber: String?
    let totalPillExpense: Double?
    let personalExpense: Double?
    let insuranceExpense: Double?
    let totalPayment: Double?
    let pharmacyName: String?
    let hospitalName: String
    let dispensingDate: String?
}

// 각 응답마다 들어있는 Pills 혹은 pills 모델링!
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
    let morning: Bool
    let afternoon: Bool
    let evening: Bool
    let instruction: Double
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
        case morning
        case afternoon
        case evening
        case instruction
    }

    static func == (lhs: Pills, rhs: Pills) -> Bool {
        return lhs.pillID == rhs.pillID
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(pillID)
    }
}

// 지금은 일단 필요없는 모델링입니다~ (요청 메서드 변경으로 현재 사용 X)
struct Instruction: Codable {
    let instructionID: Int
    let prescriptionID: Int
    let pillID: Int
    let instruction: String

    enum CodingKeys: String, CodingKey {
        case instructionID = "instructionID"
        case prescriptionID = "prescriptionID"
        case pillID = "pillID"
        case instruction = "instruction"
    }
}


//struct PrescriptionResponse: Codable {
//    let success: Bool
//    let prescriptions: [Prescriptions]?
//    let message: String
//}
//
//struct Prescriptions: Codable {
//    let prescriptionID: Int
//    let userID: String
//    let hospitalName: String
//    let prescriptionStartDate: String
//    let prescriptionEndDate: String
//    let createdAt: String
//    let updatedAt: String
//    let deletedAt: String?
//    let receipts: [Receipts]?
//    let pills: [Pills]?
//    
//    enum CodingKeys: String, CodingKey {
//        case prescriptionID
//        case userID
//        case hospitalName
//        case prescriptionStartDate
//        case prescriptionEndDate
//        case createdAt
//        case updatedAt
//        case deletedAt
//        case receipts = "Receipts"
//        case pills = "Pills"
//    }
//}
//
//struct Receipts: Codable {
//    let receiptID: Int
//    let prescriptionID: Int
//    let receiptNumber: String?
//    let totalPillExpense: Double?
//    let personalExpense: Double?
//    let insuranceExpense: Double?
//    let nonCoveredExpense: Double?
//    let totalPayment: Double?
//    let pharmacyName: String?
//    let hospitalName: String
//}
//
//struct Pills: Codable, Identifiable, Hashable {
//    
//    let id: UUID = UUID()
//    let pillID: Int
//    let pillName: String
//    let pillImage: String?
//    let pillDescription: String?
//    let pillType: String?
//    let storageMethod: String?
//    let medicineEffect: String?
//    let morning: Bool
//    let afternoon: Bool
//    let evening: Bool
//    let instruction: Double
//    let prescriptionID: Int
//    var isTaken: Bool = false
//    
//    enum CodingKeys: String, CodingKey {
//        case pillID
//        case pillName
//        case pillImage
//        case pillDescription
//        case pillType
//        case storageMethod
//        case medicineEffect
//        case prescriptionID
//        case morning
//        case afternoon
//        case evening
//        case instruction
//    }
//    
//    static func == (lhs: Pills, rhs: Pills) -> Bool {
//        return lhs.pillID == rhs.pillID
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(pillID)
//    }
//}
