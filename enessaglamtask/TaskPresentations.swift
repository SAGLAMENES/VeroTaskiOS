//
//  TaskPresentations.swift
//  Task
//
//  Created by Enes Saglam on 10.02.2024.
//

import Foundation


struct TaskPresentations : Equatable {
    let name: String
    let title: String
    let description: String
    let colorCode: String
}

extension TaskPresentations {
    init(task: Task) {
        self.init(name: task.task, title: task.title, description: task.description, colorCode: task.colorCode)
    }
}
