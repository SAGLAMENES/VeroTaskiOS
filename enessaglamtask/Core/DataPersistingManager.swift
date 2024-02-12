//
//  DataPersistingManager.swift
//  Task
//
//  Created by Enes Saglam on 10.02.2024.
//

import Foundation
import UIKit
import CoreData


protocol DataPersistManagerProtocol {
    func saveTask(model: [TaskPresentations])
    func fetchTaskDatabase(completion: @escaping(Result<[TaskItem],Error>) -> Void)
}


final class DataPersistManager : DataPersistManagerProtocol {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    func saveTask(model: [TaskPresentations]) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TaskItem(context: context)
        
        for models in model {
            item.task = models.name
            item.title = models.title
            item.descriptionData = models.description
            item.colorCode = models.colorCode
        }
      
        
        do {
            try context.save()
        } catch {
            print(DatabaseError.failedToSaveData)
        }
        
    }
    
    func fetchTaskDatabase(completion: @escaping (Result<[TaskItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request : NSFetchRequest<TaskItem>
        
        request = TaskItem.fetchRequest()
        
        do {
            let task = try context.fetch(request)
            completion(.success(task))
        } catch {
            print(DatabaseError.failedToFetchData)
        }
    }

 
    
}
