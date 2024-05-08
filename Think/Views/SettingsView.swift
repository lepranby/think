//  SettingsView.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import SwiftUI
import SwiftData

struct SettingsView: View {

    @AppStorage("isDarkModeOn") private var isDarkModeOn: Bool = false
    @AppStorage("showTimeStamp") private var showTimeStamp: Bool = false
    @AppStorage("title") private var isTitleBig: Bool = false

    @Environment(\.colorScheme) var colorScheme

    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String

    var body: some View {
        NavigationStack {
            List {
                Section ("Appearance") {
                    withAnimation(.bouncy) {
                        AnimatedToggle(isOn: $isDarkModeOn, text: "Dark mode")
                    }
                    withAnimation(.bouncy) {
                        AnimatedToggle(isOn: $isTitleBig, text: "Compact title display mode")
                    }
                    withAnimation(.bouncy) {
                        AnimatedToggle(isOn: $showTimeStamp, text: "Show time in deadlines")
                    }
                }
                Section ("App") {
                    HStack {
                        Text("Version : Build")
                        Spacer(minLength: 0)
                        Text("\(version!) : \(build!)")
                    }
                }
                Section ("Other") {
                    NavigationLink("Credits & License") { LicenseView() }
                }

            }.listSectionSpacing(2)
                .scrollIndicators(.hidden)
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(isTitleBig ? .inline : .automatic)
        }
    }
}

#Preview {
    SettingsView()
}
