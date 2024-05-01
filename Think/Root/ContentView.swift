//  ContentView.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import SwiftUI

struct ContentView: View {

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
            TabView {
                HomeView()
                    .tabItem { Label("Projects", systemImage: "number") }
                TeamsView()
                    .tabItem { Label("Developers", systemImage: "person.wave.2.fill") }
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gearshape") }
            }
    }
}

#Preview {
    ContentView()
}
