//
//  LastReviewsScreen.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 07/08/21.
//

import SwiftUI

struct LastReviewsScreen: View {
    @StateObject private var viewModel = AppModules.container.resolve(ReviewsViewModel.self)!
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
                case .initial:
                    ReviewsLoading()
                case .loading:
                    ReviewsLoading()
                case .success(let reviews):
                    ReviewsList(reviews: reviews, hasRefresh: true, onRefresh: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.viewModel.getLastReviews()
                        }
                    }).navigationTitle("Latest Reviews")
                case .failure(let error):
                    ReviewsError(error: error)
            }
        }
        .onAppear {
            self.viewModel.getLastReviews()
        }
    }
}

struct LastReviewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LastReviewsScreen()
    }
}
