//
//  ProfileView.swift
//  Foodie
//
//  Created by Muhedin Alic on 21.08.24.
//

import SwiftUI
import FirebaseStorage

struct ProfileView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImageUrl: String?
    @State private var newFullName: String = ""
    @State private var isEditingName = false
    @EnvironmentObject var authViewModel: AuthViewModel
    
    let user: User
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                if let profileImageUrl = profileImageUrl ?? user.profileImageUrl, !profileImageUrl.isEmpty {
                    ProfileImageView(imageUrl: profileImageUrl)
                        .frame(width: 90, height: 90)
                        .onTapGesture {
                            showImagePicker = true
                        }
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            showImagePicker = true
                        }
                }

                VStack(alignment: .center, spacing: 4) {
                    if isEditingName {
                        TextField("Enter new full name", text: $newFullName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {
                            authViewModel.changeUserFullName(newFullName)
                            isEditingName = false
                        }) {
                            Text("Save")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    } else {
                        Text(user.fullname)
                            .font(.headline)
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .onTapGesture {
                                isEditingName = true
                            }
                    }

                    Text(user.email)
                        .font(.subheadline)
                        .foregroundStyle(Color.theme.primaryTextColor)
                        .opacity(0.5)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
            .onChange(of: selectedImage) { newImage in
                if let newImage = newImage {
                    authViewModel.uploadProfileImage(newImage) { url in
                        self.profileImageUrl = url
                    }
                }
            }
        }
        .onAppear {
            newFullName = user.fullname
        }
    }
}


