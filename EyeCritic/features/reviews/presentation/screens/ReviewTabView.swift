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
            Text("asdasd")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search Reviews")
                }
        }
    }
}

struct ReviewTabView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewTabView()
    }
}