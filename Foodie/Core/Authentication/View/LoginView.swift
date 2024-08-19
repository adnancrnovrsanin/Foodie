//
//  LoginView.swift
//  Foodie
//
//  Created by Muhedin Alic on 07.08.24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(Color.theme.backgroundColor)
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Image("foodie-logo")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .scaledToFill()
                        
                        Text("Foodie")
                            .foregroundColor(Color.theme.primaryTextColor)
                            .font(.largeTitle)
                    }
                    
                    VStack(spacing: 32) {
                        CustomInputField(text: $email, title: "Email Address", placeholder: "name@example.com")
                            .padding(.leading)
                        
                        CustomInputField(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                            .padding(.leading)
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                // Forgot Password action
                            }) {
                                Text("Forgot Password?")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(Color.theme.primaryTextColor)
                                    .padding(.top)
                                    .padding(.trailing, 28)
                            }
                        }
                        
                    }
                    .padding(.top, 12)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.signIn(withEmail: email, password: password)
                    }) {
                        HStack {
                            Text("SIGN IN")
                                .foregroundColor(.white)
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                        }
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                        .background(Color.theme.brandRed)
                        .cornerRadius(10)
                    }
                    .padding(.bottom, 32)
                    .padding(.bottom, 24)
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                .font(.system(size: 14))
                            Text("Sign Up")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(Color.theme.primaryTextColor)
                    }

                }
                .blur(radius: viewModel.isAuthenticating ? 4 : 0)
                
                if viewModel.isAuthenticating {
                    CustomProgressView()
                }
                
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
