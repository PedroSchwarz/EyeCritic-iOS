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
                ReviewDetailsHero(
                    image: self.viewModel.image,
                    rating: review.rating,
                    isFavorite: self.viewModel.favorite
                ) {
                    self.viewModel.toggleReviewFavorite(review: review)
                    self.viewModel.getReviewFavoriteStatus(review: review)
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
        .overlay(
            ReviewFavoriteUpdateAlert(
                show: self.viewModel.state == .failure || self.viewModel.state == .success,
                state: self.viewModel.state
            ),
            alignment: .bottom
        )
        .edgesIgnoringSafeArea(.top)
        .onAppear(perform: {
            // Get review favorite status
            self.viewModel.getReviewFavoriteStatus(review: review)
            // Fetch review image for network
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
