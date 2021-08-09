//
//  ReviewDetailsSectionHeader.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 09/08/21.
//

import SwiftUI

struct ReviewDetailsSectionHeader: View {
    var icon: String
    var title: String
    
    var body: some View {
        GroupBox(content: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: icon)
            }
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .foregroundColor(.accentColor)
        })
    }
}

struct ReviewDetailsSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailsSectionHeader(icon: "link", title: "Article Link")
    }
}
