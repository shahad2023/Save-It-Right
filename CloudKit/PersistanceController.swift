//
//  PersistanceController.swift
//  NonStoppingAlarm
//
//  Created by Shouq Turki Bin Tuwaym on 09/01/2023.
//

import Foundation
import CoreData
import UIKit


struct PersistenceController {
    // A singleton for our entire app to use
    
    static let shared = PersistenceController(inMemory: false)

    
    // Storage for Core Data
    let container: NSPersistentCloudKitContainer

    
    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        // Create 10 example entities languages.
        for _ in 0..<10 {
            // we create our entity
            let warranty = Warranty(context: controller.container.viewContext)
            warranty.deviceName = Int.random(in: 1...100) > 50 ? Int.random(in: 1...100) > 50 ? "xyz" : "testing long text" : "This is supper large text"
            warranty.companyName = "What ever"
            warranty.startDate = Date()
            warranty.durationYears = Int.random(in: 0...2) > 0 ? Int32(Int.random(in: 5...10)) : 0
            warranty.durationMonths = Int.random(in: 0...2) > 0 ? Int32(Int.random(in: 5...10)) : 0
            warranty.durationDays = Int.random(in: 0...2) > 0 ? Int32(Int.random(in: 5...10)) : 0
            warranty.photo = UIImage(named: "Sport Equipm")?.pngData()
        }

        return controller
    }()
    
    
    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentCloudKitContainer(name: "Model")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}

extension Warranty {
    
    private static var WarrantyFetchRequest: NSFetchRequest<Warranty>{
        NSFetchRequest(entityName: "Warranty")
    }
    
    static func all() -> NSFetchRequest<Warranty>{
        let request: NSFetchRequest<Warranty> = WarrantyFetchRequest
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Warranty.deviceName, ascending: true)
        ]
        return request
    }
    
    static func filter(_ query: String, _ category: String, _ isActive:Bool = true) -> NSPredicate{
        if !query.isEmpty {
            return NSPredicate(format: """
                deviceName CONTAINS[cd] %@ AND
                category BEGINSWITH[cd] %@ AND
                expirationDate \(isActive ? ">" : "<=") now()
            """, query,category)
        }else{
            return NSPredicate(format: """
                category BEGINSWITH[cd] %@ AND
                expirationDate \(isActive ? ">" : "<=") now()
            """, category)
        }
    }
}
