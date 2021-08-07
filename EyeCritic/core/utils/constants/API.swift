//
//  API.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import Foundation

struct API {
    static var BASE_URL: String = "https://api.nytimes.com/svc/movies/v2/reviews"
    static var API_KEY: String = "pFhpA36Zm3zAqJIZw0ZsxH9MOtWKT5yH"
    
    struct Endpoints {
        struct AllReviews {
            static var PATH: String = "\(API.BASE_URL)/all.json?api-key=\(API.API_KEY)"
        }
    }
}
