//
//  ReviewFavoriteUpdateAlert.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 09/08/21.
//

import SwiftUI

struct ReviewFavoriteUpdateAlert: View {
    var show: Bool = false
    var state: ReviewDetailsState = .idle
    
    var body: some View {
        FloatingAlert(message: self.mapStateToMessage())
            .offset(
                y: self.show ? 0 : 150
            )
            .animation(.spring(response: 0.6, dampingFraction: 0.5))
    }
    
    // Map favorite state to message
    func mapStateToMessage() -> String {
        if self.state == .failure {
            return "An error occurred, please try again later"
        } else if self.state == .success {
            return "Review updated"
        } else {
            return ""
        }
    }
}

struct ReviewFavoriteUpdateAlert_Previews: PreviewProvider {
    static var previews: some View {
        ReviewFavoriteUpdateAlert()
    }
}
