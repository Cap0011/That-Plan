//
//  That_PlanApp.swift
//  That Plan
//
//  Created by Jiyoung Park on 2/17/25.
//

import SwiftUI

@main
struct That_PlanApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            TabView()
                .environment(\.managedObjectContext,
                                              coreDataStack.persistentContainer.viewContext)
        }
    }
}
