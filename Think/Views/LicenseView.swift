//  LicenseView.swift
//  Think
//
//  Created by Aleksej Shapran on 03.05.24

import SwiftUI

struct LicenseView: View {

    @AppStorage("isDarkModeOn") private var isDarkModeOn: Bool = false
    @AppStorage("title") private var isTitleBig: Bool = false

    @Environment(\.colorScheme) var colorScheme

    var body: some View {

        NavigationStack {
            List {
                Section ("Source") {
                    Link(destination: URL(string: "https://www.github.com/lepranby")!, label: {
                        HStack {
                            Text("Author's Github page")
                            Spacer(minLength: 0)
                            Image(systemName: "at")
                                .foregroundStyle(Color.accentColor.gradient)
                        }
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    })
                    Link(destination: URL(string: "https://www.linkedin.com/in/lepranby/")!, label: {
                        HStack {
                            Text("Author's LinkedIn page")
                            Spacer(minLength: 0)
                            Image(systemName: "link")
                                .foregroundStyle(Color.accentColor.gradient)
                        }
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    })
                }

                Section ("License") {
                    Link(destination: URL(string: "https://github.com/lepranby/think/blob/main/LICENSE")!, label: {
                        HStack {
                            Text("GNU General Public License")
                            Spacer(minLength: 0)
                            Image(systemName: "link")
                                .foregroundStyle(Color.accentColor.gradient)
                        }
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    })
                }

            }.listSectionSpacing(2)
                .scrollIndicators(.hidden)
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
                .navigationTitle("About")
                .navigationBarTitleDisplayMode(isTitleBig ? .inline : .automatic)
        }
    }
}

#Preview {
    LicenseView()
}
