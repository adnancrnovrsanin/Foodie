//
//  SettingsView.swift
//  Foodie
//
//  Created by Muhedin Alic on 17.08.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var path = NavigationPath()
    @State private var showConfirmationDialog = false
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(alignment: .leading) {
                List {
                    Section {
                        if let user = authViewModel.user {
                            NavigationLink {
                                ProfileView(user: user)
                            } label: {
                                HStack(alignment: .center) {
                                    ProfileImageView(imageUrl: user.profileImageUrl)
                                        .frame(width: 80, height: 80)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(user.fullname)
                                            .font(.headline)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                        
                                        Text(user.email)
                                            .font(.subheadline)
                                            .foregroundStyle(Color.theme.primaryTextColor)
                                            .opacity(0.5)
                                    }
                                }
                            }

                        }
                    }
                    
                    if let user = authViewModel.user {
                        Section(header: Text("Account")) {
                            ForEach(AccountOptionsViewModel.optionsForUser(user), id: \.self) { option in
                                if option == .signout {
                                    SettingItemCell(viewModel: option)
                                        .accentColor(.white)
                                        .onTapGesture {
                                            authViewModel.signOut()
                                        }
                                } else if !user.isDriver {
                                    Button {
                                        showConfirmationDialog = true
                                    } label: {
                                        SettingItemCell(viewModel: option)
                                            .accentColor(.white)
                                    }
                                    .confirmationDialog("Are you sure you want to become a driver? You won't be able to order anymore.", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
                                        Button("Yes") {
                                            authViewModel.becomeADriver()
                                        }
                                        Button("Cancel", role: .cancel) {}
                                    }
                                }
                            }
                        }
                    }
                }
                .background(Color.theme.systemBackgroundColor)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
}
