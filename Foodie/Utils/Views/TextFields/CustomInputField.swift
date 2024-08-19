//
//  CustomInputField.swift
//  Foodie
//
//  Created by Muhedin Alic on 07.08.24.
//

import SwiftUI

struct CustomInputField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(Color.theme.primaryTextColor)
                .opacity(0.8)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color.theme.primaryTextColor)
                        .opacity(0.3)
                }
                
                if isSecureField {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
                }
            }
            .foregroundColor(Color.theme.primaryTextColor)
            
            Rectangle()
                .foregroundColor(Color.theme.primaryTextColor)
                .frame(width: UIScreen.main.bounds.width - 32, height: 0.7)
                .opacity(0.5)
        }
    }
}
