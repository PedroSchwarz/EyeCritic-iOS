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
    var hasRefresh: Bool = false
    var onRefresh: () -> Void = {}
    var gridLayout: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
    
    @State private var refreshed: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            GeometryReader { scroll in
                
                if self.showRefreshIndicator(scrollPosition: scroll.frame(in: .global).minY) {
                    HStack {
                        Spacer()
                        CircularProgress(colors: [.pink, .purple, .blue], accentColor: .purple, size: 50)
                        Spacer()
                    }
                    .padding(.top, 20)
                    .onAppear {
                        self.refreshed.toggle()
                        onRefresh()
                    }
                }
                
                LazyVGrid(columns: gridLayout, content: {
                    ForEach(reviews) { item in
                        GeometryReader { card in
                            NavigationLink(
                                destination: ReviewDetailsScreen(review: item),
                                label: {
                                    ReviewsListItem(review: item)
                                        .scaleEffect(
                                            calcScale(
                                                minY: card.frame(in: .global).minY,
                                                height: UIScreen.main.bounds.height
                                            ),
                                            anchor: .center
                                        )
                                        .animation(.spring(response: 0.6, dampingFraction: 0.6))
                                })
                        }
                        .frame(minHeight: 200, maxHeight: 300)
                    }
                    .padding(.horizontal, 10)
                })
                .padding(
                    .top,
                    self.setListTopPadding(scrollPosition: scroll.frame(in: .global).minY)
                )
            }
            .frame(height: self.calcListHeight())
        }
    }
    
    // Calculate scale animation to item
    func calcScale(minY: CGFloat, height: CGFloat) -> CGFloat {
        // If top of item is less than devices height
        if ((height + (height - 100) - minY) / 1000) < 1 {
            // Scale down item
            return ((height + (height - 100) - minY) / 1000)
        }
        // Item top position is greater than 1
        if minY - 100 > 1 {
            // Scale item normally
            return 1
        } else {
            // Scale down item
            let scaleBy = ((minY - 100) / 1000) + 1
            return scaleBy
        }
    }
    
    // Calculate list height
    func calcListHeight() -> CGFloat {
        // If reviews count is even
        if self.reviews.count % 2 == 0 {
            // Return reviews count by half times item height
            return CGFloat((self.reviews.count / 2) * 210)
        } else {
            // return reviews count by half plus one, times item height
            return CGFloat(((self.reviews.count / 2) + 1) * 210)
        }
    }
    
    // Set list top padding when list has refresh functionality
    func setListTopPadding(scrollPosition: CGFloat) -> CGFloat {
        return self.showRefreshIndicator(scrollPosition: scrollPosition) ? 100 : 0
    }
    
    // Show refresh indicator when list has refresh funcionality
    func showRefreshIndicator(scrollPosition: CGFloat) -> Bool {
       return (scrollPosition > 200 || self.refreshed) && self.hasRefresh
    }
}

struct ReviewsList_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsList(reviews: [mockReview])
    }
}
