//
//  ReviewsLoading.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 07/08/21.
//

import SwiftUI

struct ReviewsLoading: View {
    var accentColor: Color = .accentColor
    
    var body: some View {
        VStack(alignment: .center, spacing: 20, content: {
            CircularProgress(
                colors: [Theme.Colors.appPink, .accentColor, Theme.Colors.appBlue],
                accentColor: self.accentColor
            )
            
            HStack(spacing: 2) {
                Text("Loading")
                ForEach(0..<3) { i in
                    Text(".")
                }
                .font(.system(size: 20))
            }
            .font(.system(size: 24))
            .foregroundColor(self.accentColor)
        })
    }
}

struct ReviewsLoading_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsLoading()
    }
}
