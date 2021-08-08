//
//  SearchReviewsSearchBar.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 08/08/21.
//

import SwiftUI

struct SearchReviewsSearchBar: View {
    @Binding var title: String
    @State private var showInput: Bool = false
    
    var onClear: () -> Void
    var onSubmit: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    self.showInput.toggle()
                    if self.showInput {
                        self.onClear()
                    }
                }
            }, label: {
                Circle()
                    .fill(Color.blue.opacity(0.6))
                    .frame(width: 48, height: 48, alignment: .center)
                    .shadow(color: .blue.opacity(0.8), radius: 5, y: 4)
                    .overlay(
                        Image(systemName:
                                self.showInput ?
                                "xmark" :
                                "magnifyingglass"
                        )
                            .resizable()
                            .frame(width: 18, height: 18, alignment: .center)
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                    )
            })
            
            TextField("Movie title", text: self.$title, onCommit: self.onSubmit)
                .foregroundColor(.black)
                .padding(13)
                .background(Color.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .scaleEffect(x: self.showInput ? 1 : 0, y: 1, anchor: .leading)
                .animation(.easeOut)
                .opacity(self.showInput ? 1 : 0.3)
                .animation(.linear(duration: 1))
                .overlay(
                    Button(action: self.onSubmit, label: {
                        Image(systemName: "arrow.forward")
                            .foregroundColor(.white)
                    })
                    .opacity(self.showInput ? 1 : 0)
                    .animation(.linear(duration: 0.1))
                    .padding(.trailing, 10),
                    alignment: .trailing
                )
                .shadow(color: .primary.opacity(0.7), radius: 8, y: 2)
        }
    }
}

struct SearchReviewsSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchReviewsSearchBar(title: .constant(""), onClear: {
            print("Cleared")
        }, onSubmit: {
            print("Submitted")
        })
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
