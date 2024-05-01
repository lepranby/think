//  ThinkApp.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import SwiftUI
import SwiftData

@main
struct ThinkApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [ ProjectModel.self, DeveloperModel.self ])
    }
}
