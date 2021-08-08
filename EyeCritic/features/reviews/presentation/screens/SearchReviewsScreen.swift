//
//  SearchReviewsScreen.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 08/08/21.
//

import SwiftUI

struct SearchReviewsScreen: View {
    @StateObject private var viewModel = AppModules.container.resolve(SearchReviewsViewModel.self)!
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                SearchReviewsSearchBar(
                    title: self.$viewModel.title) {
                        self.viewModel.clearTitleInput()
                    } onSubmit: {
                        self.viewModel.searchReviews()
                    }
                
                switch self.viewModel.state {
                    case .initial:
                        EmptyView()
                        Spacer()
                    case .loading:
                        Spacer()
                        ReviewsLoading()
                        Spacer()
                    case .failure(let error):
                        Spacer()
                        ReviewsError(error: error)
                        Spacer()
                    case .success(let reviews):
                        ReviewsList(reviews: reviews)
                }
            }
            .padding()
            .navigationTitle("Search for Reviews")
        }
    }
}

struct SearchReviewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchReviewsScreen()
            .preferredColorScheme(.dark)
    }
}
