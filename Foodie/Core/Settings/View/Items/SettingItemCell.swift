//
//  SettingItemCell.swift
//  Foodie
//
//  Created by Muhedin Alic on 17.08.24.
//

import SwiftUI

struct SettingItemCell: View {
    let viewModel: any SettingsViewModelProtocol
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: viewModel.imageName)
                .imageScale(.medium)
                .font(.title)
                .foregroundColor(Color(viewModel.imageBackgroundColor))
                .accentColor(.white)
            
            Text(viewModel.title)
                .font(.system(size: 15))
                .foregroundColor(Color.theme.primaryTextColor)
        }
        .padding(4)
    }
}

#Preview {
    SettingItemCell(viewModel: AccountOptionsViewModel.earnings)
}
