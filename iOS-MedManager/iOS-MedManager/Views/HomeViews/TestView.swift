//
//  TestView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/13/24.
//

import SwiftUI

struct TestView: View {
    @State var isbool = false
    
    var body: some View {
        NavigationStack {
            HStack {
                Button(action: {
                    if isbool {
                        isbool = false
                    } else {
                        isbool = true
                    }
                }, label: {
                    Text("Button")
                })
                
                Text("Test")
                
                NavigationLink {
                    
                } label: {
                    Text("test")
                }
            }
            .foregroundStyle(.black)
            .background(isbool ? Color.gray : Color.blue)
        }
    }
}

#Preview {
    TestView()
}
