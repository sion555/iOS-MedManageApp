//
//  RegisterView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/9/24.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            TextField("사용자 ID", text: $viewModel.userID)
                .textFieldStyle(.roundedBorder)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            TextField("사용자 이름", text: $viewModel.userName)
                .textFieldStyle(.roundedBorder)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            SecureField("비밀번호", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            Button(action: {
                viewModel.signUp()
            }, label: {
                Text("회원가입")
            })
            .padding()
            .foregroundStyle(.white)
            .bold()
            .background(Color.green)
            .clipShape(Capsule())
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(
                    title: Text("회원가입 결과"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("확인"))
                )
            }
        }
    }
}

#Preview {
    RegisterView()
}
