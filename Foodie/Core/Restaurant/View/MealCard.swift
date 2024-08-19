//
//  MealCard.swift
//  Foodie
//
//  Created by Muhedin Alic on 10.08.24.
//

import SwiftUI
import Kingfisher

struct MealCard: View {
    var meal: Meal
    
    var body: some View {
        Group {
            HStack {
                VStack(alignment: .leading) {
                    Text(meal.name)
                        .fontWeight(.semibold)
                        .font(.caption)
                    Text(meal.description)
                        .fontWeight(.medium)
                        .font(.caption2)
                        .foregroundColor(Color.theme.primaryTextColor)
                        .opacity(0.7)
                        .padding(.top, 1)
                    HStack {
                        Text("Price: ")
                            .fontWeight(.semibold)
                            .font(.caption)
                        Text(meal.price.formatedAmount)
                            .fontWeight(.semibold)
                            .font(.caption)
                            .foregroundColor(Color.theme.brandRed)
                            .padding(.top, 1)
                    }
                }
                Spacer()
                KFImage(URL(string: meal.imageUrl))
                    .retry(maxCount: 3, interval: .seconds(5))
                    .resizable()
                    .frame(maxWidth: 64, maxHeight: 64)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.rect(cornerRadius: 6))
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .clipShape(.rect(cornerRadius: 3))
    }
}

#Preview {
    MealCard(meal: fakeRestaurant.meals[0])
}
