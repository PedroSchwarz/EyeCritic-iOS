//
//  ReviewsList.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import SwiftUI
import Swinject

struct ReviewsList: View {
    var reviews: [Review]
    var gridLayout: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridLayout, content: {
                ForEach(reviews) { item in
                    NavigationLink(
                        destination: ReviewDetailsScreen(review: item),
                        label: {
                            ReviewsListItem(review: item)
                        })
                }
                .padding(.horizontal, 10)
            })
        }
    }
}

struct ReviewsList_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsList(reviews: [mockReview])
    }
}
