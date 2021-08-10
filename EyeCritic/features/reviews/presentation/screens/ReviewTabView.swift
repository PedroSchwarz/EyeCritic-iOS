//
//  ReviewTabView.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 08/08/21.
//

import SwiftUI

struct ReviewTabView: View {
    var body: some View {
        TabView {
            LastReviewsScreen()
                .tabItem {
                    Image(systemName: "book")
                    Text("Latest Reviews")
                }
            SearchReviewsScreen()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search Reviews")
                }
            FavoriteReviewsScreen()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
        }
    }
}

struct ReviewTabView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewTabView()
    }
}
