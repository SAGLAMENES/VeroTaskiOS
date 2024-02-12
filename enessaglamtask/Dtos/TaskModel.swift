//
//  TaskModel.swift
//  Task
//
//  Created by Enes Saglam on 11.02.2024.
//

import Foundation



public struct Task : Codable, Equatable{
    public let task: String
    public let title: String
    public let description: String
    public let colorCode: String

    
    init?(json: [String: Any]) {
            guard let task = json["task"] as? String,
                let title = json["title"] as? String,
                let description = json["description"] as? String,
                let colorCode = json["colorCode"] as? String else {
                    return nil
            }
            
            self.task = task
            self.title = title
            self.description = description
            self.colorCode = colorCode
        }
    
    
}
