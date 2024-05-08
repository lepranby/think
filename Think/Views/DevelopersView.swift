//  TeamsView.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import SwiftUI
import SwiftData

struct DevelopersView: View {

    @AppStorage("isDarkModeOn") private var isDarkModeOn: Bool = false
    @AppStorage("title") private var isTitleBig: Bool = false
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()

    @Query (sort: [
        SortDescriptor(\DeveloperModel.name),
        SortDescriptor(\DeveloperModel.location)
    ]) var people: [DeveloperModel]

    var body: some View {
        NavigationStack (path: $path) {
            Group {
                if people .isEmpty {
                    EmptyTeamsView()
                } else {
                    List {
                        Section {
                            ForEach(people) { developer in
                                NavigationLink(value: developer) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(developer.name)
                                            .font(.headline).fontWeight(.semibold)
                                        if developer.qualification.isEmpty {
                                                Text(developer.role)
                                                .font(.callout)
                                                .fontWeight(.light)
                                                .foregroundStyle(.gray)
                                        } else {
                                            HStack (spacing: 4) {
                                                Text(developer.qualification)
                                                Text(developer.role)
                                            }
                                            .font(.callout)
                                            .fontWeight(.light)
                                            .foregroundStyle(.gray)
                                        }
                                        if developer.location.isEmpty {
                                            Text("Location unknown")
                                                .font(.footnote).fontWeight(.light)
                                                .foregroundStyle(Color.accentColor)
                                        } else {
                                            Text("Location: \(developer.location)").font(.footnote).fontWeight(.light)
                                        }
                                    }
                                }
                            }.onDelete(perform: deleteDeveloper)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addDeveloper()
                    } label: {
                        Label("Add developer", systemImage: "person.crop.circle.badge.plus")
                    }
                }
            } 
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.automatic)
            .preferredColorScheme(isDarkModeOn ? .dark : .light)
            .navigationTitle("Developers")
            .navigationBarTitleDisplayMode(isTitleBig ? .inline : .automatic)
            .navigationDestination(for: DeveloperModel.self) { developer in
                EditDevView(developer: developer)
            }
        }
    }

//    var badge: String {
//        let count = people.count
//        return count == 0 ? "No any people yet" : "Total \(count)"
//    }

    func deleteDeveloper (at offsets: IndexSet) {

        for offset in offsets {
            let developer = people[offset]
            modelContext.delete(developer)
        }
    }

    func addDeveloper () {
        let developer = DeveloperModel(name: "", desc: "", role: "", phone: "", email: "", location: "", qualification: "", hardSkills: "", softSkills: "", github: "https://github.com/")
        modelContext.insert(developer)
        path.append(developer)
    }
}

#Preview {
    DevelopersView()
}
