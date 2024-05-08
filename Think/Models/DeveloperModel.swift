//  DeveloperModel.swift
//  Think
//
//  Created by Aleksej Shapran on 25.04.24

import Foundation
import SwiftData

@Model class DeveloperModel {

    var name: String
    var desc: String
    var phone: String
    var email: String
    var role: String
    var location: String
    var qualification: String
    var hardSkills: String
    var softSkills: String
    var github: String
    var project = [ProjectModel]()

    init(name: String, desc: String, role: String, phone: String, email: String, location: String, qualification: String, hardSkills: String, softSkills: String, github: String, project: [ProjectModel] = [ProjectModel]()) {
        self.name = name
        self.desc = desc
        self.role = role
        self.phone = phone
        self.email = email
        self.location = location
        self.qualification = qualification
        self.hardSkills = hardSkills
        self.softSkills = softSkills
        self.project = project
        self.github = github
    }

}
