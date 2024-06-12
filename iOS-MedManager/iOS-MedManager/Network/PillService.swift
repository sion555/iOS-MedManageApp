//
//  PillService.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/10/24.
//

import Foundation
import Alamofire

class PillService {
    
    static let shared = PillService()
    private init() { }
    
    func fetchPrescriptions(for date: String, completion: @escaping (Result<[Prescriptions], Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No token found"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("http://localhost:3000/prescription/date/\(date)", method: .get, headers: headers).responseDecodable(of: PrescriptionResponse.self) { response in
            switch response.result {
            case .success(let prescriptionResponse):
                if prescriptionResponse.success, let prescriptions = prescriptionResponse.prescriptions {
                    completion(.success(prescriptions))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: prescriptionResponse.message])))
                }
            case .failure(let error):
                    print("PillService의 AF.request에서 문제 발생!")
                    debugPrint(error)
                completion(.failure(error))
            }
        }
    }
}



