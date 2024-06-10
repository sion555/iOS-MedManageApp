//
//  AzureAIModel.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/5/24.
//

import Foundation

struct AnalyzeResult: Decodable {
    let status: String
    let createdDateTime: String?
    let lastUpdatedDateTime: String?
    let analyzeResult: DocumentAnalyzeResult?
}

struct DocumentAnalyzeResult: Decodable {
    let apiVersion: String
    let modelId: String
    let stringIndexType: String
    let documents: [Document]
}

struct Document: Decodable {
    let docType: String
    let fields: DocumentFields
}

struct DocumentFields: Decodable {
    let medicine: MedicineField?
    let receipt: ReceiptField?
    
    enum CodingKeys: String, CodingKey {
        case medicine = "Medicine"
        case receipt = "Receipt"
    }
}

struct MedicineField: Decodable {
    let type: String
    let valueArray: [Medicine]
}

struct Medicine: Decodable {
    let type: String
    let valueObject: PillDetails
}

struct PillDetails: Decodable {
    let pillName: PillInfo
    let pillType: PillInfo
    let instruction: PillInfo
}

struct PillInfo: Decodable {
    let type: String
    let valueString: String
    let content: String
}

struct ReceiptField: Codable {
    let type: String
    let valueArray: [Receipt]
}

struct Receipt: Codable {
    let type: String
    let valueObject: ReceiptDetail
}

struct ReceiptDetail: Codable {
    let receiptID: ReceiptInfo
    let patientName: ReceiptInfo
    let hospitalName: ReceiptInfo
    let dispensingDate: ReceiptInfo
    let outOfPocketExpenses: ReceiptInfo
    let insurerContribution: ReceiptInfo
    let nonBenefit: ReceiptInfo
    let card: ReceiptInfo
    let cash: ReceiptInfo
    let totalCount: ReceiptInfo
    let pharmacyName: ReceiptInfo
}

struct ReceiptInfo: Codable {
    let type: String
    let valueString: String
    let content: String
}




