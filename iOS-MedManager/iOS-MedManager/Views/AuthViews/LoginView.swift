//
//  LoginView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/9/24.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var isLoggedIn: Bool
    @StateObject private var viewModel = LoginViewModel()
    @State var result: String = ""
    
    var body: some View {
        VStack {
            Text(result)
                .padding(.bottom, 20)
            
            TextField("사용자 ID", text: $viewModel.userID)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 10)
            
            TextField("사용자 이름", text: $viewModel.userName)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 10)
            
            SecureField("비밀번호", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 10)
            
            Button(action: {
                viewModel.login { trytry in
                    if trytry {
                        viewModel.isLoggedIn = true
                        result = "로그인 성공🤭🤭🍀"
                        isLoggedIn = true // This will trigger the navigation
                    } else {
                        result = "로그인 실패했다."
                    }
                }
            }, label: {
                Text("🌈🌟난 로그인 버튼이야🍀")
            })
            .padding()
            .foregroundStyle(.white)
            .bold()
            .background(Color(hex: "#FFC8C3"))
            .clipShape(Capsule())
            
            NavigationLink {
                RegisterView()
            } label: {
                Text("회원가입")
                    .frame(width: 300)
                    .padding()
                    .background(Color.green)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
        }
        .padding()
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}



