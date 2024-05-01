//  HomeView.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import SwiftUI

struct HomeView: View {

    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var theme

    @AppStorage("isDarkModeOn") private var isDarkModeOn: Bool = false

    @State private var path = [ProjectModel]()
    @State private var sortOrder = SortDescriptor(\ProjectModel.name)
    @State private var searchText = ""

    var body: some View {
        NavigationStack(path: $path) {
            ProjectView(sort: sortOrder, searchString: searchText)
                .navigationDestination(for: ProjectModel.self, destination: { project in
                    EditProjectView(project: project)
                })
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                            Picker("Sort", selection: $sortOrder) {
                                Text("name")
                                    .tag(SortDescriptor(\ProjectModel.name))
                                Text("priority")
                                    .tag(SortDescriptor(\ProjectModel.priority, order: .reverse))
                                Text("date")
                                    .tag(SortDescriptor(\ProjectModel.date))
                            }
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
                .navigationBarTitleDisplayMode(.inline)
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
