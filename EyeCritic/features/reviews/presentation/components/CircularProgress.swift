//
//  CircularProgress.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 08/08/21.
//

import SwiftUI

struct CircularProgress: View {
    var colors: [Color]
    var accentColor: Color
    var size: CGFloat = 100
    
    @State private var animateCircle: Bool = false
    
    var body: some View {
        Circle()
            .stroke(
                self.accentColor.opacity(0.2),
                style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)
            )
            .frame(width: self.size, height: self.size, alignment: .center)
            .overlay(
                Circle()
                    .trim(from: animateCircle ? 0.99 : 0, to: 1)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: self.colors),
                            startPoint: .bottomTrailing,
                            endPoint: .topLeading
                        ),
                        style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)
                    )
                    .animation(
                        .easeOut(duration: 5).repeatForever(autoreverses: true),
                        value: self.animateCircle
                    )
                    .frame(width: self.size, height: self.size, alignment: .center)
                    .rotationEffect(.degrees(90))
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 1, y: 0, z: 0)
                    )
            )
            .shadow(color: self.accentColor.opacity(0.3), radius: 10, y: 2)
            .onAppear(perform: {
                withAnimation {
                    self.animateCircle.toggle()
                }
            })
    }
}

struct CircularProgress_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgress(
            colors: [Color.pink, Color.purple, Color.blue],
            accentColor: .purple
        )
    }
}
