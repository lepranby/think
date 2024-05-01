//  EditProjectView.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import SwiftUI
import SwiftData
import PhotosUI

struct EditProjectView: View {

    @Bindable var project: ProjectModel

    @State private var newTaskName = ""
    @State private var selectedLogo: PhotosPickerItem?
    @State private var isDone: Bool = false

    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()

    @Query (sort: [
        SortDescriptor(\DeveloperModel.name),
        SortDescriptor(\DeveloperModel.location)
    ]) var developers: [DeveloperModel]

    var body: some View {

        List {
            Section ("Main") {
                TextField("Project name", text: $project.name)
                TextField("Deployment target", text: $project.target)
                if let imageData = project.logo, let uiImage = UIImage(data: imageData) {
                    PhotosPicker(selection: $selectedLogo, matching: .images) {
                        VStack (alignment: .center , spacing: 12) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaleEffect(x: 1.1, y: 1.1, anchor: .center)
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 2.8)
                        }
                    }
                } else {
                    HStack {
                        PhotosPicker(selection: $selectedLogo, matching: .images) {
                            Text("Project logo").foregroundStyle(.gray.opacity(0.7))
                        }

                        Spacer(minLength: 0)
                        Image(systemName: "square.and.arrow.down").foregroundStyle(Color.accentColor)
                    }
                    .disabled(project.name.isEmpty)
                }
            }
            Section ("Core info") {
                TextField("Brief description", text: $project.details, axis: .vertical)
                TextField("Project idea", text: $project.idea, axis: .vertical)
                TextField("Features", text: $project.features, axis: .vertical)
            }
            Section ("Deadline") {
                Toggle(isOn: $project.useDeadlines.animation(), text: "The project has a deadline")
                    .foregroundStyle(.gray.opacity(0.8))
                if project.useDeadlines == true {
                    DatePicker("Start:", selection: $project.startDate)
                        .foregroundStyle(.gray.opacity(0.8))
                        .datePickerStyle(.compact)
                    DatePicker("Deadline:", selection: $project.date)
                        .foregroundStyle(.gray.opacity(0.8))
                        .datePickerStyle(.compact)
                }

            }
            Section {
                Picker("Priority", selection: $project.priority) {
                    Text("Normal").tag(1)
                    Text("Ordinary").tag(2)
                    Text("Important").tag(3)
                }
                .pickerStyle(.navigationLink)
                Picker ("Lead", selection: $project.developer) {
                    if developers.isEmpty {
                        Text("No one")
                            .tag(Optional<DeveloperModel>.none)
                    } else {
                        Text("No one")
                            .tag(Optional<DeveloperModel>.none)
                        ForEach(developers) { developer in
                            Text("\(developer.name)")
                                .tag(Optional(developer))
                        }
                    }
                }
                .pickerStyle(.navigationLink)
            } header: {
                Text("Responsibility & priority")
            } footer: {
                Text("Select the lead developer for this project.")
            }

            Section {
                ForEach(project.tasks) { task in
                    Text(task.name)
                        .strikethrough(isDone)
                }

                HStack {
                    if project.name.isEmpty {
                        TextField("New task", text: $newTaskName)
                            .disabled(project.name.isEmpty)
                    } else {
                        TextField("New task in \(project.name)", text: $newTaskName)
                    }
                    Button("+", action: addTask)
                        .disabled(project.name.isEmpty)
                }
            } header: {
                Text("Project log")
            } footer: {
                Button(action: {
                    isDone.toggle()
                }, label: {
                    Text(isDone ? "Restore all logs" : "Complete all logs").foregroundStyle(isDone ? .orange : Color.accentColor)
                }).disabled(project.tasks.isEmpty)
            }
        }
        .scrollIndicators(.hidden)
        .scrollDismissesKeyboard(.immediately)
        .listSectionSpacing(2)
        .navigationTitle("Project \(project.name)")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedLogo, loadLogo)
    }

    func loadLogo () {
        Task { @MainActor in
            project.logo = try await
            selectedLogo?.loadTransferable(type: Data.self)
        }
    }

    func addTask() {
        guard newTaskName.isEmpty == false else { return }
        withAnimation {
            let new = TaskModel(name: newTaskName)
            project.tasks.append(new)
            newTaskName = ""
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ProjectModel.self, configurations: config)
        let example = ProjectModel(name: "Harward", details: "Harward App for iOS.")
        return EditProjectView(project: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
