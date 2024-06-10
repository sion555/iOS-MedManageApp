//
//  AzureAIService.swift
//  iOS-MedManager
//
//  Created by 한범석 on 6/4/24.
//

import Foundation
import Alamofire
import SwiftUI


class AzureDocumentIntelligenceService {
    
    private let subscriptionKey = "910ac25e560247c7aaf1db99b66d28fb"
    private let endpoint = "https://dl-lyk-2.cognitiveservices.azure.com"
//    private let analyzePath = "/formrecognizer/documentModels/prescription-model:analyze?api-version=2023-07-31"
    private let analyzePath = "/formrecognizer/documentModels/medicationinformation-model:analyze?api-version=2023-07-31"
    
    func analyzeImage(imageData: Data, completion: @escaping (Result<String, Error>) -> Void) {
        let url = "\(endpoint)\(analyzePath)"
        let headers: HTTPHeaders = [
            "Ocp-Apim-Subscription-Key": subscriptionKey,
            "Content-Type": "application/octet-stream"
        ]
        
        AF.upload(imageData, to: url, headers: headers)
            .response { response in
                debugPrint(response)
                
                if let httpResponse = response.response,
                   let operationLocation = httpResponse.headers["Operation-Location"] {
                    completion(.success(operationLocation))
                } else {
                    print("network af.upload 메서드에서 문제발생! analyzeImage 메서드임")
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Operation-Location header not found."])))
                }
            }
    }
    
    func getAnalyzeResult(operationLocation: String, completion: @escaping (Result<AnalyzeResult, Error>) -> Void) {
        let headers: HTTPHeaders = [
            "Ocp-Apim-Subscription-Key": subscriptionKey
        ]
        
        AF.request(operationLocation, headers: headers)
            .responseDecodable(of: AnalyzeResult.self) { response in
                
                debugPrint(response)
                
                switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        print("network af.request 메서드에서 문제발생! getAnalyzeResult 메서드임")
                        completion(.failure(error))
                }
            }
    }
}





