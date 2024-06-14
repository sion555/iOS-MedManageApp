//
//  ConfirmationView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/13/24.
//

import SwiftUI

struct ConfirmationView: View {
    @Binding var isPresented: Bool
    @State var pillName: String = ""
    @State var pillType: String = ""
    @State var instruction: String = ""
    
    init(isPresented: Binding<Bool>, result: String) {
        self._isPresented = isPresented
        let resultData = parseResult(result)
        self._pillName = State(initialValue: resultData.pillName)
        self._pillType = State(initialValue: resultData.pillType)
        self._instruction = State(initialValue: resultData.instruction)
    }
    
    var body: some View {
        VStack {
            Text("인식된 정보가 이게 맞나요?")
                .font(.title)
                .padding()
            Form {
                Section(header: Text("Pill Name")) {
                    TextField("Pill Name", text: $pillName)
                }
                Section(header: Text("Pill Type")) {
                    TextField("Pill Type", text: $pillType)
                }
                Section(header: Text("Instruction")) {
                    TextField("Instruction", text: $instruction)
                }
            }
            .padding()
        }
        .navigationTitle("정보 확인")
    }
    
    private func parseResult(_ result: String) -> (pillName: String, pillType: String, instruction: String) {
        guard let data = result.data(using: .utf8) else {
            return ("", "", "")
        }

        do {
            // JSON 데이터를 AnalyzeResult 구조체로 디코딩
            let analyzeResult = try JSONDecoder().decode(AnalyzeResult.self, from: data)

            if let documents = analyzeResult.analyzeResult?.documents {
                for document in documents {
                    if let medicineField = document.fields.medicine {
                        for medicine in medicineField.valueArray {
                            let pillName = medicine.valueObject.pillName.content
                            let pillType = medicine.valueObject.pillType.content
                            let instruction = medicine.valueObject.instruction.content
                            return (pillName, pillType, instruction)
                        }
                    }
                }
            }
        } catch {
            print("Error parsing result: \(error.localizedDescription)")
        }

        return ("", "", "")
    }
}
#Preview {
    ConfirmationView(isPresented: .constant(true), result: "Sample Result")
}


