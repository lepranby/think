//  HomeView.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import SwiftUI
import SwiftData

struct HomeView: View {

    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var scheme

    @AppStorage("isDarkModeOn") private var isDarkModeOn: Bool = false
    @AppStorage("title") private var isTitleBig: Bool = false

    @Query(sort:
            [SortDescriptor(\ProjectModel.priority, order: .reverse),
             SortDescriptor(\ProjectModel.name)])
    var projects: [ProjectModel]

    @State private var path = [ProjectModel]()
    @State private var sortOrder = SortDescriptor(\ProjectModel.name)
    @State private var searchText = ""

    var body: some View {
        NavigationStack(path: $path) {
            ProjectView(sort: sortOrder, searchString: searchText)
                .navigationDestination(for: ProjectModel.self, destination: { project in
                    EditProjectView(project: project)
                })
            // Depricate 03.05
            // .searchable(text: $searchText)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Picker(selection: $sortOrder) {
                            Text("by name")
                                .tag(SortDescriptor(\ProjectModel.name))
                            Text("by deadline")
                                .tag(SortDescriptor(\ProjectModel.date))
                        } label: {
                            Image(systemName: "books.vertical.fill")
                        }
                        .disabled(projects.isEmpty)
                        .pickerStyle(.navigationLink)

                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addProject()
                        } label: {
                            Label("New project", systemImage: "plus.circle")
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
                .navigationTitle("Projects")
                .navigationBarTitleDisplayMode(isTitleBig ? .inline : .automatic)
        }
    }
}

extension HomeView {

    func addProject() {
        let newProject = ProjectModel()
        modelContext.insert(newProject)
        path = [newProject]
    }
}

#Preview {
    HomeView()
}
