//
//  ReviewDetailsScreen.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 08/08/21.
//

import SwiftUI

struct ReviewDetailsScreen: View {
    @StateObject private var viewModel = AppModules.container.resolve(ReviewDetailsViewModel.self)!
    
    var review: Review
    @State private var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if self.viewModel.image == nil {
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
                    Image(uiImage: UIImage(data: self.viewModel.image!)!)
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
                                    Text(review.rating.isEmpty ? "NA" : review.rating)
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .bold()
                                )
                                .offset(x: 0, y: 25)
                                .shadow(color: .accentColor.opacity(1), radius: 5, y: 2),
                            alignment: .bottom
                        )
                }
                
                VStack(alignment: .leading, spacing: 20, content: {
                    Text(review.headline)
                        .font(.title2)
                        .offset(x: 0, y: self.animate ? 0 : 10)
                        .animation(.easeOut(duration: 0.2))
                    
                    Text(review.summary)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.secondary)
                        .offset(x: 0, y: self.animate ? 0 : 10)
                        .animation(.easeOut(duration: 0.4))
                    
                    ReviewDetailsSection(
                        icon: "link",
                        title: "Article Link",
                        content: review.displayTitle,
                        link: review.link
                    )
                    .offset(x: 0, y: self.animate ? 0 : 10)
                    .animation(.easeOut(duration: 0.6))
                    
                    ReviewDetailsSection(
                        icon: "figure.wave",
                        title:  "Written by",
                        content: review.byLine
                    )
                    .offset(x: 0, y: self.animate ? 0 : 10)
                    .animation(.easeOut(duration: 0.8))
                    
                    ReviewDetailsSection(
                        icon: "calendar",
                        title: "Publication Date",
                        content: review.formattedDate
                    )
                    .offset(x: 0, y: self.animate ? 0 : 10)
                    .animation(.easeOut(duration: 1))
                })
                .padding(.top, self.viewModel.image != nil ? 20 : 0)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear(perform: {
            self.viewModel.getProductImage(imageUrl: review.imageUrl)
            withAnimation {
                self.animate = true
            }
        })
    }
}

struct ReviewDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailsScreen(
            review: mockReview
        )
    }
}
