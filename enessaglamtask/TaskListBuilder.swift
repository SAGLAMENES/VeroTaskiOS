//
//  TaskListBuilder.swift
//  Task
//
//  Created by Enes Saglam on 10.02.2024.
//

import Foundation
import UIKit
final class TaskListBuilder {
    
    static func make() -> TaskListVC {
        let storyboard = UIStoryboard(name: "TaskList", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "TaskVC") as! TaskListVC
        
        let taskService = TaskService()
        let dataService = DataService()
        let dataPersistManager = DataPersistManager()

        view.viewModel = TaskListViewModel(taskService: taskService, dataService: dataService, dataPersistManager: dataPersistManager)
        
        return view
    }
    
}
