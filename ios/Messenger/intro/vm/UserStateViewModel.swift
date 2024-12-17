//
//  UserStateViewModel.swift
//  Messenger
//
//  Created by user271419 on 12/15/24.
//

import Foundation

@MainActor
class UserStateViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var isBusy = false
    @Published var hasAcceptedEULA = false
    @Published var errorMessage: String? = nil
    
    private let eulaAcceptedKey = "eulaAccepted"
    private let userDefaults = UserDefaults.standard
    
    private let isLoggedInKey = "isLoggedIn"
    
    init() {
        self.isLoggedIn = userDefaults.bool(forKey: isLoggedInKey)
        self.hasAcceptedEULA = userDefaults.bool(forKey: eulaAcceptedKey)
    }
    
    func acceptEULA() {
        self.hasAcceptedEULA = true
        userDefaults.set(true, forKey: eulaAcceptedKey)
    }
    
    func sendOTP(phoneNumber: String) async -> Result<Bool, NetworkStateError> {
        isBusy = true
        self.errorMessage = nil
        
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            isBusy = false
            return .success(true)
        } catch {
            isBusy = false
            return .failure(.unknownError)
        }
    }
    
    private func updateLoginStatus(isLoggedIn: Bool) {
        self.isLoggedIn = isLoggedIn
        userDefaults.set(isLoggedIn, forKey: isLoggedInKey)
    }
    func signIn(phoneNumber: String, otp: String) async -> Result<Bool, NetworkStateError> {
        isBusy = true
        self.errorMessage = nil
        
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            updateLoginStatus(isLoggedIn: true)
            isBusy = false
            return .success(true)
        } catch {
            isBusy = false
            return .failure(.unknownError)
        }
    }
    
    func signOut() async -> Result<Bool, NetworkStateError> {
        isBusy = true
        self.errorMessage = nil
        
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            updateLoginStatus(isLoggedIn: false)
            isBusy = false
            return .success(true)
        } catch {
            isBusy = false
            return .failure(.unknownError)
        }
    }
}
