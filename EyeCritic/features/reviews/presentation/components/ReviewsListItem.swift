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
                CircularProgress(colors: [.white, .gray], accentColor: .purple, size: 50)
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
                .fill(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.3))
                .cornerRadius(10)
                .blur(radius: 5)
                .shadow(color: Color.black.opacity(0.1), radius: 2)
        )
        .background(Color.white.opacity(0.1))
        .onAppear(perform: {
            self.viewModel.getProductImage(imageUrl: review.imageUrl)
        })
        .navigationTitle("Latest Reviews")
    }
}

struct ReviewsListItem_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsListItem(review: mockReview)
    }
}
