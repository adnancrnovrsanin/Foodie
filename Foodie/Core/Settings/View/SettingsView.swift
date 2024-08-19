//
//  SettingsView.swift
//  Foodie
//
//  Created by Muhedin Alic on 17.08.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section {
                    if let user = authViewModel.user {
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
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .imageScale(.small)
                                .font(.title2)
                                .foregroundStyle(Color.theme.primaryTextColor)
                                .opacity(0.5)
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
                            } else {
                                SettingItemCell(viewModel: option)
                                    .accentColor(.white)
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

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
}
