//  SettingsView.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import SwiftUI

struct SettingsView: View {

    @AppStorage("isDarkModeOn") private var isDarkModeOn: Bool = false
    @AppStorage("showTimeStamp") private var showTimeStamp: Bool = true
    @Environment(\.colorScheme) var colorScheme

    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String

    var body: some View {
        NavigationStack {
            List {
                Section ("Appearance") {
                    withAnimation(.bouncy) {
                        Toggle(isOn: $isDarkModeOn, text: "Dark mode")
                    }
                    withAnimation(.bouncy) {
                        Toggle(isOn: $showTimeStamp, text: "Show time in project rows")
                    }
                }
                Section ("App") {
                    HStack {
                        Text("Version")
                        Spacer(minLength: 0)
                        Text(version!)
                    }
                    Link(destination: URL(string: "https://www.github.com/lepranby")!, label: {
                        HStack {
                            Text("Author's Github page")
                            Spacer(minLength: 0)
                            Image(systemName: "at")
                                .foregroundStyle(Color.accentColor)
                        }
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    })
                }.listSectionSpacing(0)

            }
            .scrollIndicators(.hidden)
            .preferredColorScheme(isDarkModeOn ? .dark : .light)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
