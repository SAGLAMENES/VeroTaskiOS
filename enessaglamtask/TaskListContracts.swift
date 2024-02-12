//
//  TaskListContracts.swift
//  Task
//
//  Created by Enes Saglam on 10.02.2024.
//

import Foundation
protocol TaskListViewModelProtocol : AnyObject {
    var delegate : TaskListViewModelDelegate? { get set }
    func load()
}

enum TaskListViewModelOutput : Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showMovieList([TaskPresentations])
}

enum TaskListViewRoute {
    case detail(TaskListViewModelProtocol)
}

protocol TaskListViewModelDelegate : AnyObject {
    func handleViewModelOutput(_ output: TaskListViewModelOutput)
}
