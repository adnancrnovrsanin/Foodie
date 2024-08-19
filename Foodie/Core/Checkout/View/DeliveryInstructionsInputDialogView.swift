//
//  DeliveryInstructionsInputDialogView.swift
//  Foodie
//
//  Created by Muhedin Alic on 15.08.24.
//

import SwiftUI

struct DeliveryInstructionsInputDialogView: View {
    @Binding var isPresented: Bool
    @State private var inputText: String = ""
    
    var title: String
    var onSubmit: (String) -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.body)
                .foregroundStyle(Color.theme.primaryTextColor)
            
            CustomTextEditorInput(text: $inputText, title: "", hasTitle: false)
            
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .padding()
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Button("Submit") {
                    onSubmit(inputText)
                    isPresented = false
                }
                .padding()
                .buttonStyle(PlainButtonStyle())
                .frame(width: 110, height: 40)
                .background(Color.theme.brandRed)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 8))
            }
            .padding(.horizontal, 10)
        }
        .padding()
        .background(Color.theme.backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 10)
        .frame(maxWidth: 300)
    }
}

#Preview {
    DeliveryInstructionsInputDialogView(isPresented: .constant(true), title: "Enter any special delivery instructions you have for the driver") { something in return }
}
