//
//  NetworkStateError.swift
//  Messenger
//
//  Created by Arnab Kar on 12/16/24.
//
import Foundation
import Alamofire

enum NetworkStateError: Error {
    case authError
    case networkError(AFError)
    case serverError(Int)
    case timedOut
    case rateLimited
    case custom(String)
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .authError:
            return NSLocalizedString("Authentication failed. Please check your credentials and try again.", comment: "Authentication Error")
        case .networkError(let error):
            return "A network error occured: \(error.localizedDescription)"
        case .serverError(let code):
            return NSLocalizedString("A server error occured with code: \(code)", comment: "Server unavailable Error")
        case .timedOut:
            return NSLocalizedString("Request timed out. Please check your connection and try again", comment: "Request Timeout")
        case .rateLimited:
            return NSLocalizedString("You have exceeded the rate limit. Please try again later", comment: "Rate Limit Error")
        case .custom(let message):
            return message
        case .unknownError:
            return NSLocalizedString("An unknown error occured. Please try again later", comment: "Unknown Error")
        }
    }
    
    // Similarly add failureReason, if needed
}
