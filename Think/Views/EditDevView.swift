//  EditDevView.swift
//  Think
//
//  Created by Aleksej Shapran on 25.04.24

import SwiftUI

struct EditDevView: View {

    @Bindable var developer: DeveloperModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Form {
            Section ("Personal") {
                TextField("Full name", text: $developer.name)
                TextField("Details", text: $developer.desc)
            }
            Section ("Location") {
                HStack (spacing: 6) {
                    Image(systemName: "mappin.and.ellipse").resizable().frame(width: 16, height: 16)
                        .foregroundStyle(colorScheme == .dark ? .white : .red)
                    TextField("The place where it happened", text: $developer.location)
                }
            }
            Section ("Role") {
                TextField("Role", text: $developer.role)
            }
        }
        .scrollDismissesKeyboard(.automatic)
        .scrollIndicators(.hidden)
        .navigationTitle("People")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    EditDevView(developer: DeveloperModel(name: "Mark Zuckerberg", desc: "Good boy", role: "C# software ingeneer", location: "CA. USA"))
//}
