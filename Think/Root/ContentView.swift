//  ContentView.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import SwiftUI

struct ContentView: View {

    @Environment(\.colorScheme) var colorScheme
    @State private var sortOrder = SortDescriptor(\DeveloperModel.name)
    @State private var searchText = ""

    var body: some View {
            TabView {
                HomeView()
                    .tabItem { Label("Projects", systemImage: "book.pages.fill") }
                DevelopersView()
                    .tabItem { Label("Developers", systemImage: "person.2") }
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gearshape") }
            }
    }
}

#Preview {
    ContentView()
}
