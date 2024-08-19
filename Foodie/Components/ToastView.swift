//
//  ToastView.swift
//  Foodie
//
//  Created by Muhedin Alic on 13.08.24.
//

import SwiftUI

struct ToastView: View {
    @Binding var toastMessage: String
    
    var body: some View {
        Text(toastMessage)
            .font(.subheadline)
            .foregroundColor(.white)
            .padding()
            .background(Color.black)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.bottom, 50)
    }
}

#Preview {
    ToastView(toastMessage: .constant("This is a toast message"))
}
