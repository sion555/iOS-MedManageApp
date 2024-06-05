//
//  RegisterView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/5/24.
//

import SwiftUI

struct RegisterView: View {
    @State var userName: String = ""
    @State var password: String = ""
    var body: some View {
        
        VStack {
            Text("회원가입")
                .font(.title2)
            VStack {
                TextField("사용자명", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                SecureField("비밀번호", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding()
            
            
            Button(action: {}, label: {
                Text("회원가입")
                    .frame(width: 300)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            
        }
    }
}

#Preview {
    RegisterView()
}
