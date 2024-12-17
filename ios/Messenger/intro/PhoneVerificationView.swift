//
//  ContentView.swift
//  Messenger
//
//  Created by user271419 on 12/15/24.
//

import SwiftUI

struct PhoneVerificationView: View {
    @EnvironmentObject var vm: UserStateViewModel
    
    @State private var phoneNumber: String = ""
    @State private var verificationCode: String = ""
    @State private var isVerificationSent: Bool = false
    @State private var isCodeValid: Bool = false
    @State private var timerCount: Int = 30
    @State private var timerRunning: Bool = false
    @State private var isError: Bool = false
    @State private var errorMessage: String = ""
    
    let titleText = "Verify your phone number"
    let descriptionText = """
This app will send an SMS message to verify your phone number. Enter
    your country code and phone number.
"""
    let otpDigitCount = 6
    let timerCountdownValue = 30 // 30 secs
    
    var body: some View {
        NavigationView {
            VStack {
                Text(titleText)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top, 20)
                Text(descriptionText)
                    .font(.body)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                Spacer()
                
                VStack {
                    Text("Enter your phone number")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    TextField("+1 (XXX) XXX-XXXX", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, lineWidth: 1))
                        .padding(.horizontal, 20)
                }
                
                if isVerificationSent {
                    VStack {
                        Text("Enter \(otpDigitCount) digit verification code")
                            .id("Phone_identifier")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)
                        
                        TextField("000000", text: $verificationCode)
                            .id("Otp_Identifier")
                            .keyboardType(.numberPad)
                            .lineLimit(1)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, lineWidth: 1))
                            .padding(.horizontal, 20)
                            .onChange(of: verificationCode) { _ in
                                if verificationCode.count == otpDigitCount {
                                    isCodeValid = true
                                } else {
                                    isCodeValid = false
                                }
                            }
                    }
                }
                Spacer()
                
                ButtonView(
                    title: isVerificationSent ? "Verify Code" : "Send Verification Code",
                    disabled: phoneNumber.isEmpty || (isVerificationSent && !isCodeValid),
                    action: {
                        Task {
                            if isVerificationSent {
                                await signIn()
                            } else {
                                await sendOTP()
                            }
                        }
                    },
                    backgroundColor: .blue,
                    font: .headline
                )
                
                //Timer / Resend Verification code
                if isVerificationSent {
                    if timerCount > 0 {
                        Text("Resend code in \(timerCount)s")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    } else {
                        Button(action: {
                            resetVerificationProcess()
                        }) {
                            Text("Resend Code")
                                .foregroundColor(.blue)
                                .padding(.top, 5)
                        }
                    }
                }
                
                //Error message
                if isError {
                    Text(errorMessage)
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
            }
            .padding(.top, 40)
            .navigationBarHidden(true)
            .onAppear{
                resetVerificationProcess()
            }
        }
        .padding()
    }
    
    private func sendOTP() async{
        let result = await vm.sendOTP(phoneNumber: phoneNumber)
        switch result {
        case .success(_): // _ or let isSuccess
            isVerificationSent = true
            startTimer()
        case .failure(let error):
            isVerificationSent = false
            isError = true
            errorMessage = error.localizedDescription
        }
    }
    
    private func signIn() async {
        let result = await vm.signIn(phoneNumber: phoneNumber, otp: verificationCode)
        switch result {
        case .success(_):
            isError = false
            print("Code verified succesfully")
        case .failure(let error):
            isError = true
            errorMessage = error.localizedDescription
        }
    }
    
    private func startTimer() {
        timerRunning = true
        timerCount = timerCountdownValue
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            timer in
            if self.timerCount > 0 {
                self.timerCount -= 1
            } else {
                timer.invalidate()
                self.timerRunning = false
            }
        }
    }
    
    private func resetVerificationProcess() {
        phoneNumber = ""
        verificationCode = ""
        isVerificationSent = false
        timerCount = timerCountdownValue
        isError = false
    }
}

#Preview {
    PhoneVerificationView()
        .environmentObject(UserStateViewModel())
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
}
