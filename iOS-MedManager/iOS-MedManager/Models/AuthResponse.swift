//
//  AuthResponse.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/3/24.
//

import Foundation

struct SignUpResponse: Codable {
    let success: Bool
    let member: Member
    let message: String
}


struct Member: Codable {
    let userID: String
    let userName: String
    let password: String
}


struct SignInResponse: Codable {
    let success: Bool
    let token: String?
    let member: SignInResponseMember
    let message: String
}


struct SignInResponseMember: Codable {
    let userID: String
}
