//
//  HeaderView.swift
//  Foodie
//
//  Created by Muhedin Alic on 11.08.24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "location")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundStyle(Color.theme.brandRed)
            
            Text("Use current location")
                .foregroundStyle(Color.theme.primaryTextColor)
                .font(.headline)
            
            Image(systemName: "chevron.down")
                .resizable()
                .frame(width: 16, height: 8)
                .foregroundStyle(Color.theme.brandRed)
        }
    }
}

#Preview {
    HeaderView()
}
