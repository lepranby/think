//  DeveloperModel.swift
//  Think
//
//  Created by Aleksej Shapran on 25.04.24

import Foundation
import SwiftData

@Model class DeveloperModel {

    var name: String
    var desc: String
    var role: String
    var location: String
    var project = [ProjectModel]()

    init(name: String, desc: String, role: String, location: String, project: [ProjectModel] = [ProjectModel]()) {
        self.name = name
        self.desc = desc
        self.role = role
        self.location = location
        self.project = project
    }

}
