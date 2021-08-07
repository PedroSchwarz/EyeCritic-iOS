//
//  ReviewsLocalDataSource.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import Foundation
import Combine
import SwiftUI
import CoreData

protocol ReviewsLocalDataSource {
    func getCachedReview() -> AnyPublisher<[ReviewModel], Failure>
    
    func cacheReviews(reviews: [ReviewModel]) -> Void
}

struct ReviewsLocalDataSourceImpl: ReviewsLocalDataSource {
    var viewContext: NSManagedObjectContext
    
    func getCachedReview() -> AnyPublisher<[ReviewModel], Failure> {
        let request: NSFetchRequest<ReviewData> = ReviewData.fetchRequest()
        
        do {
            let result = try viewContext.fetch(request)
            let modelsList: [ReviewModel] = result.map { ReviewModel.fromLocalReview(data: $0) }
            return Result.Publisher(modelsList)
                .eraseToAnyPublisher()
        } catch {
            return Result.Publisher(Failure(type: .cache))
                .eraseToAnyPublisher()
        }
    }
    
    func cacheReviews(reviews: [ReviewModel]) {
        reviews.forEach { model in
            let data = ReviewData(context: viewContext)
            data.display_title = model.display_title
            data.byline = model.byline
            data.favorite = false
            data.headline = model.headline
            data.imageUrl = model.multimedia?.src ?? ""
            data.link = model.link.url
            data.mpaa_rating = model.mpaa_rating
            data.publication_date = model.publication_date
            data.summary_short = model.summary_short
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
