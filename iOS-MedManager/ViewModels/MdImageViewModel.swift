//
//  ImageViewModel.swift
//  iOS-MedManager
//
//  Created by 이유경 on 6/3/24.
//

import Foundation
import Alamofire

class ImageFinder: ObservableObject {
    @Published var images: [MedicineImage] = []
    let apiKey = "Qd7VtFyAhbm9SirmBLOHUiR0zqd9E5cPhcNKacAfqUqb4vav19SOOKL/1pcM2v2pqKScshbSbZBlUnfcVZ93/Q=="
    let endPoint = "http://apis.data.go.kr/1471000/MdcinGrnIdntfcInfoService01/getMdcinGrnIdntfcInfoList01"

    func getImage(query: String) {
        let params: Parameters = ["serviceKey": apiKey, "type": "json", "item_name": query]

        AF.request(endPoint, method: .get, parameters: params, encoding: URLEncoding.default).responseString { response in
            switch response.result {
            case .success(let value):
                print("Response String: \(value)")
                do {
                    let data = Data(value.utf8)
                    let decodedResponse = try JSONDecoder().decode(MedicineImageRoot.self, from: data)
                    self.images = decodedResponse.body.items
//                    print("Images: \(self.images)")
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Error occurred: \(error.localizedDescription)")
            }
        }
    }
}
