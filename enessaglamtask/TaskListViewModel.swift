//
//  TaskListViewModel.swift
//  Task
//
//  Created by Enes Saglam on 09.02.2024.
//

import Foundation


final class TaskListViewModel : TaskListViewModelProtocol {
    
    var delegate: TaskListViewModelDelegate?
    
    private let taskService : TaskServiceProtocol!
    private let dataService : DataServiceProtocol!
    private let dataPersistManager : DataPersistManagerProtocol!
    
    private var taskList : [TaskPresentations] = []
    
    
    init(taskService: TaskServiceProtocol, dataService: DataServiceProtocol, dataPersistManager: DataPersistManagerProtocol){
        self.taskService = taskService
        self.dataService = dataService
        self.dataPersistManager = dataPersistManager
    }
    

    func load() {
        
        notify(.updateTitle("Task"))
        notify(.setLoading(false))
        taskService.authenticate { accessToken in
            self.dataService.fetchTasks(accessToken: accessToken) { tasks  in
                self.notify(.setLoading(true))
            
                let response =  tasks.map(TaskPresentations.init)
                
                self.taskList = response
                self.notify(.showMovieList(response))
            }
        }
    }
    
    
    private func notify(_ output: TaskListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
}
