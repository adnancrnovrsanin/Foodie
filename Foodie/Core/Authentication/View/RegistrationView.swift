//
//  RegistrationView.swift
//  Foodie
//
//  Created by Muhedin Alic on 07.08.24.
//

import SwiftUI

struct RegistrationView: View {
    @State var email = ""
    @State var fullname = ""
    @State var password = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        ZStack {
            Color(Color.theme.backgroundColor)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .padding()
                        .foregroundStyle(Color.theme.primaryTextColor)
                }
                
                Text("Create new account")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.theme.primaryTextColor)
                    .frame(width: 250)
                
                Spacer()

                VStack {
                    VStack(spacing: 56) {
                        CustomInputField(text: $fullname, title: "Full Name", placeholder: "Enter your name")
                        CustomInputField(text: $email, title: "Email Address", placeholder: "name@exmaple.com")
                        CustomInputField(text: $password, title: "Create Password", placeholder: "Enter your password", isSecureField: true)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Button {
                        viewModel.registerUser(withEmail: email, fullname: fullname, password: password)
                    } label: {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                            .background(Color.theme.brandRed)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 0, y: 0)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .foregroundColor(.white)
            .padding(.top, 32)
            .blur(radius: viewModel.isAuthenticating ? 4 : 0)
            
            if viewModel.isAuthenticating {
                CustomProgressView()
            }
        }
    }
}

#Preview {
    RegistrationView()
        .environmentObject(AuthViewModel())
}
