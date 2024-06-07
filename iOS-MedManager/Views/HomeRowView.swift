//
//  HomeRowView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/3/24.
//

import SwiftUI

struct HomeRowView: View {
    var body: some View {
         List {
             Section {
                 HStack {
                         Image(systemName: "pills")
                             .foregroundStyle(.gray)
                         Text("감기약")
                             .font(.headline)
                         Spacer()
                         Button(action: {}, label: {
                             Image(systemName: "checkmark.circle")
                         })
                 }
                     .padding()
                     .background(Color(UIColor.systemGray6))
                 .cornerRadius(10)
             } header: {
                 Text("아침")
                     .font(.title)
                     .fontWeight(.bold)
                     .foregroundStyle(.blue)
             }
            
        }
    }
}

#Preview {
    HomeRowView()
}
