//
//  MedImageModel.swift
//  iOS-MedManager
//
//  Created by 이유경 on 6/3/24.
//

import Foundation

struct MedicineImage: Codable, Identifiable {
    let id: String // 품목 일련번호 - id 구분
    let name: String // 품목명
    let image: String // 제품 이미지
    
    enum CodingKeys: String, CodingKey {
        case id = "ITEM_SEQ"
        case name = "ITEM_NAME"
        case image = "ITEM_IMAGE"
    }
}

struct MedicineImageBody: Codable {
    let items: [MedicineImage]
    let pageNo: Int
    let totalCount: Int
}

struct MedicineImageRoot: Codable {
    let body: MedicineImageBody
}
