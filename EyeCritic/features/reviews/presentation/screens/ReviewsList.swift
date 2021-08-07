//
//  ReviewsList.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import SwiftUI

struct ReviewsList: View {
    @StateObject private var viewModel = ReviewsViewModel(useCase: GetLastReviews(repository: ReviewsRepositoryImpl(
        network: NetworkInfoImpl(),
        remote: ReviewsRemoteDataSourceImpl(service: ReviewsService()),
        local: ReviewsLocalDataSourceImpl(viewContext: PersistenceController.shared.container.viewContext)
    )))
    
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
