//
//  TaskModel.swift
//  BucketListcrUD
//
//  Created by admin on 26/12/2021.
//

import Foundation

class TaskModel {
    //get all task
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
        
        let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
    
    //add new tasks
    static func addTaskWithObjective(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Create the url to request
        if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/") {
            // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
            var request = URLRequest(url: urlToReq)
            // Set the method to POST
            request.httpMethod = "POST"
            // Create some bodyData and attach it to the HTTPBody
            let bodyData = "objective=\(objective)"
            request.httpBody = bodyData.data(using: .utf8)
            // Create the session
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
            task.resume()
        }
    }
    //update the task
    static func updateTask(id: Int,objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)/")!)
        request.httpMethod = "PUT"
        do {
            
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let parameterDictionary = ["objective":objective]
            let httpBody = try JSONSerialization.data(withJSONObject: parameterDictionary)
            
            request.httpBody = httpBody
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: completionHandler)
            task.resume()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    //delete the task
    static func deleteTask(id: Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        var request = URLRequest(url: URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)/")!)
        request.httpMethod = "DELETE"
        
        let bodyData = "id=\(id)"
        request.httpBody = bodyData.data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
        task.resume()
    }
    
    
}
