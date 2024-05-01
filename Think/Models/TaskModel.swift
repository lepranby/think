//  TaskModel.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import Foundation
import SwiftData

@Model class TaskModel {

    var name: String
    var isCompleted: Bool = false

    init(name: String) {
        self.name = name
    }
}
