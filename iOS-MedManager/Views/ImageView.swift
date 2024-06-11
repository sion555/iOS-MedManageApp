//
//  ImageVIew.swift
//  iOS-MedManager
//
//  Created by 이유경 on 6/3/24.
//

import SwiftUI

let sample = iOS_MedManager.MedicineImage(id: "202200658", name: "우먼스타이레놀정", image: "https://nedrug.mfds.go.kr/pbp/cmn/itemImageDownload/1OKRXo9l4Dx")

struct ImageVIew: View {
    let yak: MedicineImage
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: yak.image)) {
                image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            } placeholder: {
                Image(systemName: "pills.fill")
            }
            Text(yak.name)
        }
        
    }
}

#Preview {
    ImageVIew(yak: sample)
}
