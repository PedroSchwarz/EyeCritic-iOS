//
//  ReviewDetailsScreen.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 08/08/21.
//

import SwiftUI

struct ReviewDetailsScreen: View {
    var review: Review
    
    var body: some View {
        Text("Hello, World!")
            .navigationTitle(self.review.displayTitle)
    }
}

struct ReviewDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailsScreen(
            review: mockReview
        )
    }
}
