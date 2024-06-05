//
//  LoginView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/5/24.
//

import SwiftUI

struct LoginView: View {
   
    @State var userName: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                Text("로그인")
                    .font(.title2)
                VStack {
                    TextField("userName", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)
                    Button(action: {}, label: {
                        Text("로그인")
                    }).foregroundStyle(.white)
                        .frame(width: 300)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    NavigationLink {
                        RegisterView()
                    } label: {
                        Text("회원가입")
                            .frame(width: 300)
                            .padding()
                            .foregroundStyle(.white)
                            .background(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }.padding(10)
            }
        }
    }
}


#Preview {
    LoginView()
}
