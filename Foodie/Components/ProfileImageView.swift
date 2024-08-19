//
//  ProfileImageView.swift
//  Foodie
//
//  Created by Muhedin Alic on 17.08.24.
//

import SwiftUI
import Kingfisher

struct ProfileImageView: View {
    let imageUrl: String?
    
    var body: some View {
        ZStack {
            if let imageUrl = imageUrl {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .clipShape(Circle())
                    .padding(.bottom, 16)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .clipShape(Circle())
                    .padding(.bottom, 16)
                    .foregroundStyle(Color(.systemGray4))
            }
        }
    }
}

#Preview {
    ProfileImageView(imageUrl: nil)
}
