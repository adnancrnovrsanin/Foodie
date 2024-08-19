//
//  CustomTextEditorInput.swift
//  Foodie
//
//  Created by Muhedin Alic on 15.08.24.
//

import SwiftUI

struct CustomTextEditorInput: View {
    @Binding var text: String
    
    let title: String
    let hasTitle: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            if hasTitle {
                Text(title)
                    .font(.headline)
                    .padding(.bottom, 5)
                    .foregroundStyle(Color.theme.primaryTextColor)
            }
            
            TextEditor(text: $text)
                .foregroundStyle(Color.theme.primaryTextColor)
                .frame(height: 150)
                .padding(.all, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.theme.primaryTextColor, lineWidth: 1)
                        .opacity(0.5)
                )
        }
    }
}

#Preview {
    CustomTextEditorInput(text: .constant("Enter your text here..."), title: "Multiline input", hasTitle: true)
}
