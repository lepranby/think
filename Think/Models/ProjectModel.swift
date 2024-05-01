//  ProjectModel.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import Foundation
import SwiftData

@Model class ProjectModel {

    var name: String
    var details: String
    var idea: String
    var features: String
    var target: String
    var startDate: Date
    var date: Date
    var useDeadlines: Bool
    var priority: Int

    var developer: DeveloperModel?

    @Attribute(.externalStorage) var logo: Data?

    @Relationship(deleteRule: .cascade) var tasks = [TaskModel]()

    init(name: String = "", details: String = "", features: String = "", idea: String = "", date: Date = .now, startDate: Date = .now, useDeadlines: Bool = false, priority: Int = 2, target: String = "", logo: Data? = nil, developer: DeveloperModel? = nil) {
        self.name = name
        self.details = details
        self.features = features
        self.idea = idea
        self.date = date
        self.startDate = date
        self.priority = priority
        self.useDeadlines = useDeadlines
        self.logo = logo
        self.target = target
        self.developer = developer
    }
}
