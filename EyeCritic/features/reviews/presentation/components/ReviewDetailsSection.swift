//
//  ReviewDetailsSection.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 09/08/21.
//

import SwiftUI

struct ReviewDetailsSection: View {
    @Environment(\.openURL) var openURL
    
    var icon: String
    var title: String
    var content: String
    var link: String? = nil
    
    var body: some View {
        Section(header: ReviewDetailsSectionHeader(
                    icon: icon,
                    title: title
        )) {
            if let articleLink = link {
                Button(content) {
                    openURL(URL(string: articleLink)!)
                }
                    .foregroundColor(Theme.Colors.appBlue)
                    .padding(.horizontal, 10)
            } else {
                Text(content)
                    .padding(.horizontal, 10)
            }
        }
    }
}

struct ReviewDetailsSection_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailsSection(
            icon: "figure.wave",
            title: "Written by",
            content: mockReview.displayTitle
        )
    }
}
