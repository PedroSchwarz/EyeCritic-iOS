//
//  AppModules.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 07/08/21.
//

import Foundation
import CoreData
import Swinject
import Network

struct AppModules {
    // Container
    static var container = Container()
    
    static func declareModules() {
        let monitor = NWPathMonitor()
        monitor.start(queue: DispatchQueue(label: "Network monitor"))
        
        // Utils
        container.register(NWPathMonitor.self) { _ in monitor }
        container.register(NetworkInfo.self) { r in NetworkInfoImpl(monitor: r.resolve(NWPathMonitor.self)!) }
        container.register(NSManagedObjectContext.self) { _ in  PersistenceController.shared.container.viewContext }

        // DataSources
        container.register(ReviewsRemoteDataSource.self) { _ in ReviewsRemoteDataSourceImpl(service: ReviewsService()) }
        container.register(ReviewsLocalDataSource.self) { r in ReviewsLocalDataSourceImpl(viewContext: r.resolve(NSManagedObjectContext.self)!) }

        // Repositories
        container.register(ReviewsRepository.self) { r in
            ReviewsRepositoryImpl(
                network: r.resolve(NetworkInfo.self)!,
                remote: r.resolve(ReviewsRemoteDataSource.self)!,
                local: r.resolve(ReviewsLocalDataSource.self)!
            )
        }
        
        // UseCases
        container.register(GetLastReviews.self) { r in GetLastReviews(repository: r.resolve(ReviewsRepository.self)!) }

        // ViewModels
        container.register(ReviewsViewModel.self) { r in ReviewsViewModel(useCase: r.resolve(GetLastReviews.self)!) }
        container.register(ReviewsListItemViewModel.self) { r in ReviewsListItemViewModel() }
    }
}
