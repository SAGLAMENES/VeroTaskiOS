//
//  TaskService.swift
//  Task
//
//  Created by Enes Saglam on 11.02.2024.
//

import Foundation
import Foundation
import Alamofire

struct AuthResponse: Decodable {
    let oauth: OAuthResponse
}

struct OAuthResponse: Decodable {
    let access_token: String
}

public protocol TaskServiceProtocol {
    func authenticate(completion: @escaping (_ accessToken: String) -> Void)
}


public final class TaskService: TaskServiceProtocol {

    public init() { }

    public func authenticate(completion: @escaping (_ accessToken: String) -> Void) {
        let headers : HTTPHeaders = [
            "Authorization": "Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz",
            "Content-Type": "application/json"]
        
        let parameters = [
            "username": "365",
            "password": "1"]

        let urlString = "https://api.baubuddy.de/index.php/login"
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let json):
                    guard let accessToken = json as? [String: Any], let token = accessToken["oauth"] as? [String: Any], let access_token = token["access_token"] as? String else {
                        return
                    }
                    completion(access_token)
                case .failure(let error):
                    print(error)
                }
            }
    }

}
