//
//  Save_It_RightApp.swift
//  Save It Right
//
//  Created by Shouq Turki Bin Tuwaym on 12/02/2023.
//

import SwiftUI

@main
struct Save_It_RightApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            logo()
                .preferredColorScheme(.dark)
                .tint(.accentColor)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.managedObjectContext, PersistenceController.managedContext)
        }
    }
}
