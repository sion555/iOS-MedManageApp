//
//  CameraView.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/13/24.
//

//import SwiftUI
//
//struct CameraView: View {
//    @Binding var isPresented: Bool
//    @Binding var image: UIImage?
//
//    var body: some View {
//        VStack {
//            Text("카메라 뷰 (오버레이로 가이드라인 추가)")
//                .font(.title)
//                .padding()
//            Spacer()
//            Button("Use Photo") {
//                
//                
//                image = UIImage(named: "sample_image") // 예시
//                isPresented = true
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//        }
//        .navigationTitle("카메라")
//    }
//}
//
//#Preview {
//    CameraView(isPresented: .constant(true), image: .constant(nil))
//}


import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    
    var sourceType: UIImagePickerController.SourceType = .camera

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraView>) {}
}

#Preview {
    CameraView(image: .constant(nil))
}
