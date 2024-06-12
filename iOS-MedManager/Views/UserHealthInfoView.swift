//
//  UserHealthInfoView.swift
//  iOS-MedManager
//
//  Created by ksy on 6/12/24.
//

import SwiftUI

struct UserHealthInfoView: View {
    
    @State var disease = "" // 기저질환 입력을 위한 상태 변수
    @State private var diseaseList: [String] = [] // 기저질환 목록을 저장할 배열
    @State var allergy = "" // 알레르기 입력 상태 변수
    @State private var allergyList: [String] = [] // 알레르기 목록 저장할 배열
    @State var nutrient = ""
    @State private var nutrientList: [String] = []
    @State var yearDisease = "" // 1년간 진단 받은 병명
    @State private var yearDiseaseList: [String] = [] //진단 목록을 저장할 배열
    
    var body: some View {
        NavigationStack {
            List {
                //기저질환
                Section {
                    VStack(alignment: .leading) {
                        Text("기저질환")
                            .font(.title)
                            .bold()
                        Text("평소 앓고 있는 만성적 질병")
                            .foregroundStyle(.secondary)
                            .fontWeight(.bold)
                        
                        // Section 내부에 질환 목록과 텍스트 필드 추가
                        Section {
                            // ForEach를 이용해 질환 목록을 표시
                            ForEach(diseaseList.indices, id: \.self) { index in
                                    let disease = diseaseList[index] // 현재 인덱스에 해당하는 질환을 가져옴
                                HStack {
                                    Text(disease)
                                        .font(.title3)
                                        .bold()
                                        .frame(width: 295, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.primary, lineWidth: 1)
                                        )
                                    Button(action: {
                                        diseaseList.remove(at: index)
                                    }, label: {
                                        Image(systemName: "trash")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .padding(.horizontal, 5)
                                            .foregroundColor(.red)
                                    })
                                }
                            }
                            
                            Spacer()
                            // 텍스트 필드와 버튼을 포함하는 HStack
                            HStack {
                                TextField("기저질환 병명 추가", text: $disease)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .font(.title3)
                                    .foregroundColor(.primary)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    ).padding(.trailing, 5)
                                
                                // 버튼 클릭 시 diseaseList에 입력된 병명을 추가
                                Button(action: {
                                    // 빈 값이 아니면 diseaseList에 추가
                                    if !disease.isEmpty {
                                        diseaseList.append(disease)
                                        disease = "" // 추가 후 텍스트 필드를 비움
                                    }
                                }, label: {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                })
                            }
                        }
                    }.padding(.vertical, 10)
                }
                //알러지
                Section {
                    VStack(alignment: .leading) {
                        Text("알레르기")
                            .font(.title)
                            .bold()
                        Text("특정 사람에게만 과민방응을 일으키는 것")
                            .foregroundStyle(.secondary)
                            .fontWeight(.bold)
                        
                        // Section 내부에 목록과 텍스트 필드 추가
                        Section {
                            // ForEach를 이용해 목록을 표시
                            ForEach(allergyList.indices, id: \.self) { index in
                                let allergy = allergyList[index] // 현재 인덱스에 해당하는 질환을 가져옴
                                HStack {
                                    Text(allergy)
                                        .font(.title3)
                                        .bold()
                                        .frame(width: 295, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.primary, lineWidth: 1)
                                        )
                                    Button(action: {
                                        allergyList.remove(at: index)
                                    }, label: {
                                        Image(systemName: "trash")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .padding(.horizontal, 5)
                                            .foregroundColor(.red)
                                    })
                                }
                            }
                            Spacer()
                            // 텍스트 필드와 버튼을 포함하는 HStack
                            HStack {
                                TextField("알레르기 추가", text: $allergy)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .font(.title3)
                                    .foregroundColor(.primary)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    ).padding(.trailing, 5)
                                
                                // 버튼 클릭 시 입력된 병명을 추가
                                Button(action: {
                                    // 빈 값이 아니면 List에 추가
                                    if !allergy.isEmpty {
                                        allergyList.append(allergy)
                                        allergy = "" // 추가 후 텍스트 필드를 비움
                                    }
                                }, label: {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                })
                            }
                        }
                    }.padding(.vertical, 10)
                }
                
                //복용 중인 건강기능식품
                Section {
                    VStack(alignment: .leading) {
                        Text("복용 중인 건강기능식품")
                            .font(.title)
                            .bold()
                        Text("평소 복용 중인 건강기능식품")
                            .foregroundStyle(.secondary)
                            .fontWeight(.bold)
                        
                        // Section 내부에 목록과 텍스트 필드 추가
                        Section {
                            // ForEach를 이용해 목록을 표시
                            ForEach(nutrientList.indices, id: \.self) { index in
                                let nutrient = nutrientList[index] // 현재 인덱스에 해당하는 질환을 가져옴
                                HStack {
                                    Text(nutrient)
                                        .font(.title3)
                                        .bold()
                                        .frame(width: 295, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.primary, lineWidth: 1)
                                        )
                                    Button(action: {
                                        nutrientList.remove(at: index)
                                    }, label: {
                                        Image(systemName: "trash")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .padding(.horizontal, 5)
                                            .foregroundColor(.red)
                                    })
                                }
                            }
                            
                            Spacer()
                            // 텍스트 필드와 버튼을 포함하는 HStack
                            HStack {
                                TextField("복용중인 건강기능식품 추가", text: $nutrient)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .font(.title3)
                                    .foregroundColor(.primary)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    ).padding(.trailing, 5)
                                
                                // 버튼 클릭 시 입력된 병명을 추가
                                Button(action: {
                                    // 빈 값이 아니면 List에 추가
                                    if !nutrient.isEmpty {
                                        nutrientList.append(nutrient)
                                        nutrient = "" // 추가 후 텍스트 필드를 비움
                                    }
                                }, label: {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                })
                            }
                        }
                    }.padding(.vertical, 10)
                }
                //1년간 진단받은 병명
                Section {
                    VStack(alignment: .leading) {
                        Text("1년간 진단 받은 병명")
                            .font(.title)
                            .bold()
                        Text("지난 1년간 진단 받은 병명")
                            .foregroundStyle(.secondary)
                            .fontWeight(.bold)
                        
                        // Section 내부에 목록과 텍스트 필드 추가
                        Section {
                            // ForEach를 이용해 목록을 표시
                            ForEach(yearDiseaseList.indices, id: \.self) { index in
                                let yearDisease = yearDiseaseList[index] // 현재 인덱스에 해당하는 질환을 가져옴
                                HStack {
                                    Text(yearDisease)
                                        .font(.title3)
                                        .bold()
                                        .frame(width: 295, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.primary, lineWidth: 1)
                                        )
                                    Button(action: {
                                        yearDiseaseList.remove(at: index)
                                    }, label: {
                                        Image(systemName: "trash")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .padding(.horizontal, 5)
                                            .foregroundColor(.red)
                                    })
                                }
                            }
                            Spacer()
                            // 텍스트 필드와 버튼을 포함하는 HStack
                            HStack {
                                TextField("1년간 진단 받은 병명 추가", text: $yearDisease)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .font(.title3)
                                    .foregroundColor(.primary)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    ).padding(.trailing, 5)
                                
                                // 버튼 클릭 시 입력된 병명을 추가
                                Button(action: {
                                    // 빈 값이 아니면 List에 추가
                                    if !yearDisease.isEmpty {
                                        yearDiseaseList.append(yearDisease)
                                        yearDisease = "" // 추가 후 텍스트 필드를 비움
                                    }
                                }, label: {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                })
                            }
                        }
                       
                    }.padding(.vertical, 10)
                }
            }.scrollContentBackground(.hidden)
            
        }.navigationTitle("특이사항 추가")
    }
}

#Preview {
    UserHealthInfoView()
}
