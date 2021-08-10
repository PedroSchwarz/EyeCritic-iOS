//
//  FavoriteReviewsScreen.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 09/08/21.
//

import SwiftUI

struct FavoriteReviewsScreen: View {
    @StateObject private var viewModel = AppModules.container.resolve(FavoriteReviewsViewModel.self)!
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                    case .initial:
                        ReviewsLoading()
                    case .loading:
                        ReviewsLoading()
                    case .success(let reviews):
                        ReviewsList(reviews: reviews)
                    case .failure(let error):
                        ReviewsError(error: error)
                }
            }
            .navigationTitle("Favorite Reviews")
        }
        .onAppear {
            self.viewModel.getFavoriteReviews()
        }
    }
}

struct FavoriteReviewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteReviewsScreen()
    }
}
