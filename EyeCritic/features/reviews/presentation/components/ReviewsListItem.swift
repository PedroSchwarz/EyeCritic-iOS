//
//  ReviewsListItem.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 07/08/21.
//

import SwiftUI
import UIKit

struct ReviewsListItem: View {
    var review: Review
    
    @StateObject private var viewModel = AppModules.container.resolve(ReviewsListItemViewModel.self)!
    
    var body: some View {
        VStack {
            if self.viewModel.image == nil {
                CircularProgress(
                    colors: [Theme.Colors.appPink, .accentColor, Theme.Colors.appBlue],
                    accentColor: .purple,
                    size: 50
                )
                    .padding(.vertical, 20)
            } else {
                Image(uiImage: UIImage(data: self.viewModel.image!)!)
                    .resizable()
                    .frame(height: 90, alignment: .center)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(self.review.displayTitle)
                    .font(.title3)
                    .foregroundColor(.primary)
                
                Text(self.review.summary)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
        }
        .cornerRadius(10)
        .background(
            Rectangle()
                .fill(Theme.Colors.appReviewCard)
                .cornerRadius(10)
                .blur(radius: 0)
                .shadow(color: Color.black.opacity(0.5), radius: 5)
        )
        .onAppear(perform: {
            self.viewModel.getProductImage(imageUrl: review.imageUrl)
        })
    }
}

struct ReviewsListItem_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsListItem(review: mockReview)
    }
}
