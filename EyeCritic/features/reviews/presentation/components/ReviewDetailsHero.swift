//
//  ReviewDetailsHero.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 09/08/21.
//

import SwiftUI

struct ReviewDetailsHero: View {
    var image: Data?
    var rating: String
    var isFavorite: Bool
    var onClick: () -> Void
    
    var body: some View {
        if image == nil {
            HStack {
                Spacer()
                CircularProgress(
                    colors: [Theme.Colors.appPink, .accentColor, Theme.Colors.appBlue],
                    accentColor: .accentColor,
                    size: 50
                )
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.top, 100)
        } else {
            Image(uiImage: UIImage(data: image!)!)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: 500)
                .cornerRadius(20)
                .shadow(color: .secondary.opacity(0.3), radius: 10, y: 4)
                .overlay(
                    Circle()
                        .fill(Color.accentColor)
                        .frame(width: 64, height: 64)
                        .overlay(
                            Text(rating.isEmpty ? "NA" : rating)
                                .foregroundColor(.white)
                                .font(.title)
                                .bold()
                        )
                        .offset(x: 0, y: 25)
                        .shadow(color: .accentColor.opacity(1), radius: 5, y: 2),
                    alignment: .bottom
                )
                .overlay(
                    Button(action: self.onClick, label: {
                        Image(systemName: self.isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 24, height: 20)
                            .foregroundColor(.red)
                            .background(
                                Circle()
                                    .fill(Theme.Colors.appReviewCard)
                                    .frame(width: 40, height: 40)
                            )
                            .shadow(radius: 5, y: 5)
                    })
                    .offset(x: -20, y: 10),
                    alignment: .bottomTrailing
                )
        }
    }
}

struct ReviewDetailsHero_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailsHero(image: nil, rating: "R", isFavorite: false) {
            print("Clicked")
        }
    }
}
