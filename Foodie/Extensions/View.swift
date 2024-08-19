//
//  View.swift
//  Foodie
//
//  Created by Muhedin Alic on 18.08.24.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
