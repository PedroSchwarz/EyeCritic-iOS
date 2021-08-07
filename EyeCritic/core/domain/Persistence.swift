//
//  Persistence.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import CoreData

struct PersistenceController {
    // Controller
    static let shared = PersistenceController()
    // Container
    let container: NSPersistentContainer
    // Initialization
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "EyeCritic")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    // Preview Testing
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = ReviewD(context: viewContext)
//            newItem.timestamp = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
}
