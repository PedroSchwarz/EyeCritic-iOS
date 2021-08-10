//
//  FloatingAlert.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 09/08/21.
//

import SwiftUI

struct FloatingAlert: View {
    var message: String
    
    var body: some View {
        HStack {
            Text(message)
            Spacer()
        }
        .foregroundColor(.white)
        .padding()
        .background(Theme.Colors.appBlue)
        .cornerRadius(10)
        .padding()
        .shadow(radius: 10)
    }
}

struct FloatingAlert_Previews: PreviewProvider {
    static var previews: some View {
        FloatingAlert(message: "Success")
    }
}
