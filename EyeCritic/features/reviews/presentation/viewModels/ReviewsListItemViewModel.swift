//
//  ReviewsListItemViewModel.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 08/08/21.
//

import Foundation
import SwiftUI
import Alamofire

class ReviewsListItemViewModel: ObservableObject {
    @Published var image: Data?
    
    func getProductImage(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            AF.request(url).response(queue: .main) { data in
                switch data.result {
                    case .success(let data):
                        self.image = data
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}
