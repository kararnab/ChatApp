//
//  APIClient.swift
//  Messenger
//
//  Created by Arnab Kar on 12/16/24.
//

import Alamofire
import Combine


// Usage: APIClient.shared.sendOtp()
class APIClient {
    static let shared = APIClient()
    private let baseUrl = "https://your-api-base-url.com"
    
    func sendOtp(phoneNumber: String, completion: @escaping (Result<SendOtpResponse, Error>) -> Void) {
        let url = "\(baseUrl)/sendOtp"
        let parameters: [String: String] = ["phoneNumber": phoneNumber]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: SendOtpResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func login(phoneNumber: String, otp: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let url = "\(baseUrl)/login"
        let parameters: [String: String] = ["phoneNumber": phoneNumber, "otp": otp]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchConversation(completion: @escaping (Result<ConversationMessageResponse, Error>) -> Void) {
        let url = "\(baseUrl)/fetchConversation"
        
        AF.request(url, method: .get)
            .responseDecodable(of: ConversationMessageResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }

    }
    
}
