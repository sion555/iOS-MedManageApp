//
//  AuthService.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/9/24.
//

import Foundation
import Alamofire
import SwiftUI

class AuthService {
    
    static let shared = AuthService()
    private init() { }
    
    
    // MARK: - 약톡톡 회원가입 메서드
    
    func signUp(userID: String, userName: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let params: Parameters = [
            "userID": userID,
            "userName": userName,
            "password": password
        ]
        
        AF.request("http://localhost:3000/members/sign-up", method: .post, parameters: params, encoding: JSONEncoding.default).responseDecodable(of: SignUpResponse.self) { response in
            switch response.result {
                case .success(let signUpResponse):
                    if signUpResponse.success {
                        completion(.success("회원가입 성공 ! 럭키비키 ~"))
                    } else {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "회원가입이 실패했잖아? 완전 럭키비키잖아 ~~~"])))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print("AuthService의 signUp 메서드에서 문제 발생!")
            }
        }
    }
    
    // MARK: - 약톡톡 로그인 메서드
    
    func signIn(userID: String, userName: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let params: Parameters = [
            "userID": userID,
            "userName": userName,
            "password": password
        ]
        
        AF.request("http://localhost:3000/members/sign-in", method: .post, parameters: params, encoding: JSONEncoding.default).responseDecodable(of: SignInResponse.self) { response in
            print(response)
            switch response.result {
                case .success(let loginResponse):
                    if loginResponse.success, let token = loginResponse.token {
                        UserDefaults.standard.set(token, forKey: "token")
                        completion(.success(token))
                    } else {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "로그인 실패 ~ !"])))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                    print("AuthService의 signIn 메서드에서 문제 발생!")
                    debugPrint(error)
            }
        }
    }
}


