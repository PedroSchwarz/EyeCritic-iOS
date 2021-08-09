//
//  ReviewsError.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 07/08/21.
//

import SwiftUI

struct ReviewsError: View {
    var error: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20, content: {
            Circle()
                .fill(Theme.Colors.appReviewCard)
                .overlay(
                    Image(systemName: "tray.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.accentColor)
                            .frame(width: 100, height: 100, alignment: .center)
                )
                .frame(width: 150, height: 150, alignment: .center)
                .shadow(radius: 10, y: 10)
            Text(error)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.accentColor)
        })
    }
}

struct ReviewsError_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsError(error: "No reviews found for today")
            
    }
}
