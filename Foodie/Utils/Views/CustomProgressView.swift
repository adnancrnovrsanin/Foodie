//
//  CustomProgressView.swift
//  Foodie
//
//  Created by Muhedin Alic on 07.08.24.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .accentColor(.white)
            .scaleEffect(x: 2, y: 2, anchor: .center)
            .frame(width: 96, height: 96)
            .background(Color(.systemGray4))
            .cornerRadius(20)
    }
}

#Preview {
    CustomProgressView()
}
