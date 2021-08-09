//
//  ReviewDetailsScreen.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 08/08/21.
//

import SwiftUI

struct ReviewDetailsScreen: View {
    @Environment(\.openURL) var openURL
    @StateObject private var viewModel = AppModules.container.resolve(ReviewDetailsViewModel.self)!
    
    var review: Review
    @State private var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if self.viewModel.image == nil {
                    HStack {
                        Spacer()
                        CircularProgress(colors: [.white, .gray], accentColor: .purple, size: 50)
                        Spacer()
                    }
                    .padding(.vertical, 20)
                    .padding(.top, 100)
                } else {
                    Image(uiImage: UIImage(data: self.viewModel.image!)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 500)
                        .cornerRadius(20)
                        .shadow(color: .secondary.opacity(0.3), radius: 10, y: 4)
                }
                
                VStack(alignment: .leading, spacing: 20, content: {
                    Text(review.headline)
                        .font(.title2)
                        .offset(x: 0, y: self.animate ? 0 : 10)
                        .animation(.easeOut(duration: 0.2))
                    
                    Text(review.summary)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.secondary)
                        .offset(x: 0, y: self.animate ? 0 : 10)
                        .animation(.easeOut(duration: 0.4))
                    
                    Section(header: ReviewDetailsSectionHeader(
                                icon: "link",
                                title: "Article Link")
                    ) {
                        Button(review.displayTitle) {
                            openURL(URL(string: review.link)!)
                        }
                    }
                    .offset(x: 0, y: self.animate ? 0 : 10)
                    .animation(.easeOut(duration: 0.6))
                    
                    Section(header: ReviewDetailsSectionHeader(
                                icon: "figure.wave",
                                title: "Written by")
                    ) {
                        Text(review.byLine)
                    }
                    .offset(x: 0, y: self.animate ? 0 : 10)
                    .animation(.easeOut(duration: 0.8))
                    
                    Section(header: ReviewDetailsSectionHeader(
                                icon: "calendar",
                                title: "Publication Date")
                    ) {
                        Text(review.formattedDate)
                    }
                    .offset(x: 0, y: self.animate ? 0 : 10)
                    .animation(.easeOut(duration: 1))
                })
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear(perform: {
            self.viewModel.getProductImage(imageUrl: review.imageUrl)
            withAnimation {
                self.animate = true
            }
        })
    }
}

struct ReviewDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailsScreen(
            review: mockReview
        )
    }
}
