//
//  DataService.swift
//  Task
//
//  Created by Enes Saglam on 11.02.2024.
//

import Foundation
import Alamofire

public protocol DataServiceProtocol {
    func fetchTasks(accessToken: String, completion: @escaping (_ tasks: [Task]) -> Void)
}

public final class DataService: DataServiceProtocol {
    
    public init() { }
    
    public func fetchTasks(accessToken: String, completion: @escaping (_ tasks: [Task]) -> Void) {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        let urlString = "https://api.baubuddy.de/dev/index.php/v1/tasks/select"
        
        AF.request(urlString, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Task].self) { response in
                switch response.result {
                case .success(let tasks):
                    completion(tasks)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
