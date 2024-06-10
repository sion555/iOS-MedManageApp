//
//  LoginViewModel.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/9/24.
//

import Foundation
import Combine


import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var userID: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var showingAlert: Bool = false
    @Published var alertMessage: String = ""
    
    func signUp() {
        AuthService.shared.signUp(userID: userID, userName: userName, password: password) { result in
            switch result {
                case .success(let message):
                    self.alertMessage = message
                case .failure(let error):
                    self.alertMessage = "회원 가입에 실패했습니다. 이 메시지를 개발자에게 보내서 따지세요:\n \(error.localizedDescription)"
            }
            self.showingAlert = true
        }
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        AuthService.shared.signIn(userID: userID, userName: userName, password: password) { result in
            switch result {
                case .success:
                    completion(true)
                case .failure(let error):
                    self.alertMessage = "로그인에 실패했습니다. 이 메시지를 개발자에게 협박 문자로 보내세요:\n \(error.localizedDescription)"
                    self.showingAlert = true
                    completion(false)
            }
        }
    }
}

