//  ProjectView.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import SwiftUI
import SwiftData

struct ProjectView: View {

    @AppStorage("showTimeStamp") private var showTimeStamp: Bool = true

    @Query(sort:
            [SortDescriptor(\ProjectModel.priority, order: .reverse),
             SortDescriptor(\ProjectModel.name)])
    var projects: [ProjectModel]

    var body: some View {
        Group {
            if projects.isEmpty {
                EmptyListView()
            } else {
                List {
                    Section {
                        ProjectRow()
                    }
                }
            }
        }
    }

    init(sort: SortDescriptor<ProjectModel>, searchString: String) {
        _projects = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }

//    var badge: String {
//        let count = projects.count
//        return count == 0 ? "No projects" : "TOTAL (\(count))"
//    }
}

#Preview {
    ProjectView(sort: SortDescriptor(\ProjectModel.name), searchString: "")
}


struct ProjectRow: View {

    @Environment(\.modelContext) var modelContext
    @AppStorage("showTimeStamp") private var showTimeStamp: Bool = true

    @Query(sort:
            [SortDescriptor(\ProjectModel.priority, order: .reverse),
             SortDescriptor(\ProjectModel.name)])
    var projects: [ProjectModel]

    var body: some View {
        ForEach(projects) { project in
            NavigationLink(value: project) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack (alignment: .top) {
                        if let imageData = project.logo, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipShape(.rect(cornerRadius: 12))
                        } else {
                            ZStack {
                                Rectangle()
                                    .frame(width: 64, height: 64)
                                    .clipShape(.rect(cornerRadius: 12))
                                    .foregroundStyle(Color.accentColor.gradient)
                                Text(project.name.prefix(1)).font(.title).foregroundStyle(.white.gradient)
                            }
                        }
                        VStack (alignment: .leading, spacing: 4) {
                            Text(project.name)
                                .font(.headline).fontWeight(.semibold)
                            Text(project.details)
                                .font(.callout).fontWeight(.regular)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                            if project.target.isEmpty {
                                Text("Unknown target")
                                    .font(.footnote).fontWeight(.light)
                                    .foregroundStyle(.secondary)
                            } else {
                                Text("Target: \(project.target)").font(.footnote).fontWeight(.light)
                                    .foregroundStyle(.secondary)
                            }
                        }

                    }
                    HStack (spacing: 12) {
                        Text("Deadline:")
                            .font(.footnote)
                            .fontWeight(.regular)
                        if showTimeStamp == true {
                            Text(project.useDeadlines ? "\(project.date.formatted(date: .abbreviated, time: .shortened))" : "Open-ended")
                                .font(.footnote)
                                .fontWeight(.light)
                                .foregroundStyle(project.useDeadlines ? .secondary : Color.accentColor.opacity(0.8))
                        } else {
                            Text(project.useDeadlines ? "\(project.date.formatted(date: .abbreviated, time: .omitted))" : "Open-ended")
                                .font(.footnote)
                                .fontWeight(.light)
                                .foregroundStyle(project.useDeadlines ? .secondary : Color.accentColor.opacity(0.8))
                        }
                    }
                    .padding(.leading, 6)
                }
            }
        }
        .onDelete(perform: deleteRow)
    }

    func deleteRow(_ indexSet: IndexSet) {
        for index in indexSet {
            let project = projects[index]
            modelContext.delete(project)
        }
    }

}
