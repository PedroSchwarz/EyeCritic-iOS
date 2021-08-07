//
//  ReviewsList.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import SwiftUI
import Swinject

struct ReviewsList: View {
    @StateObject private var viewModel = AppModules.container.resolve(ReviewsViewModel.self)!
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
                case .initial:
                    Text("Wait")
                case .loading:
                    ProgressView()
                case .success(let reviews):
                    List {
                        ForEach(reviews) { item in
                            Text(item.displayTitle)
                        }
                    }
                case .failure(let error):
                    Text(error)
            }
        }
        .onAppear {
            self.viewModel.getLastReviews()
        }
    }
}

struct ReviewsList_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsList()
    }
}
