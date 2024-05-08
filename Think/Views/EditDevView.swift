//  EditDevView.swift
//  Think
//
//  Created by Aleksej Shapran on 25.04.24

import SwiftUI

struct EditDevView: View {

    @Bindable var developer: DeveloperModel

    var body: some View {
        Form {
            Section ("Personal") {
                HStack (spacing: 6) {
                    Image(systemName: "person").resizable().frame(width: 14, height: 14)
                        .foregroundStyle(Color.accentColor)
                    TextField("Full name", text: $developer.name)
                }
                HStack (spacing: 6) {
                    Image(systemName: "person.wave.2").resizable().frame(width: 14, height: 14)
                        .foregroundStyle(Color.accentColor)
                    TextField("Details", text: $developer.desc)
                }
                HStack (spacing: 6) {
                    Image(systemName: "phone").resizable().frame(width: 14, height: 14)
                        .foregroundStyle(Color.accentColor)
                    TextField("Phone number", text: $developer.phone)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                }
                HStack (spacing: 6) {
                    Image(systemName: "at").resizable().frame(width: 14, height: 14)
                        .foregroundStyle(Color.accentColor)
                    TextField("E-Mail", text: $developer.email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                }
            }
            Section ("Current location") {
                HStack (spacing: 6) {
                    Image(systemName: "location").resizable().frame(width: 14, height: 14)
                        .foregroundStyle(Color.accentColor)
                    TextField("USA/London/Remote etc.", text: $developer.location)
                }
            }
            Section ("Role") {
                HStack (spacing: 6) {
                    Image(systemName: "person.fill.questionmark").resizable().frame(width: 14, height: 14)
                        .foregroundStyle(Color.accentColor)
                    TextField("Role", text: $developer.role)
                }

            }
            Section ("Skills") {
                TextField("Junior/Middle/Senior/Team Lead", text: $developer.qualification)
                TextField("Hard Skills", text: $developer.hardSkills, axis: .vertical)
                TextField("Soft Skills", text: $developer.softSkills, axis: .vertical)
            }
            Section {
                HStack (spacing: 6) {
                    Image(systemName: "square.stack.3d.up.fill").resizable().frame(width: 14, height: 14)
                        .foregroundStyle(Color.accentColor)
                    TextField("", text: $developer.github)
                }
            } header: {
                Text("Github")
            } footer: {
                Text("Like https://github.com/ + alias")
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .listSectionSpacing(2)
        .scrollIndicators(.hidden)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    EditDevView(developer: DeveloperModel(name: "Mark Zuckerberg", desc: "Good boy", role: "C# software ingeneer", location: "CA. USA"))
//}
