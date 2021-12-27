//
//  ViewController.swift
//  BucketListcrUD
//
//  Created by admin on 14/12/2021.
//

import UIKit
//import CoreData

struct taskInfo {
    
    var objective: String
    var id: Int
    
    
    init?(dict: [String: Any]){
        guard let objective = dict["objective"] as? String,
              let id = dict["id"] as? Int
        else{
            return nil
        }
        
        self.objective = objective
        self.id = id
    }
}

class BucketListViewController: UITableViewController , AddItemTableViewControllerDelegate {
    
    var items = [taskInfo]()
    
    //let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getAllTasks()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell" ,for: indexPath)
        cell.textLabel?.text = items[indexPath.row].objective
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem{
            let navigationController = segue.destination as! UINavigationController
            
            let addItemTableController = navigationController.topViewController as! AddItemTableViewController
            
            addItemTableController.delegate = self
        }else if sender is IndexPath{
            let navigationController = segue.destination as! UINavigationController
            
            let addItemTableController = navigationController.topViewController as! AddItemTableViewController
            
            addItemTableController.delegate = self
            
            let indexPath = sender as! IndexPath
            let item1 = items[indexPath.row]
            addItemTableController.item = item1.objective
            addItemTableController.indexPath = indexPath
            
        }
    }
   
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        TaskModel.deleteTask(id: items[indexPath.row].id , completionHandler: {
            data, response, error in
            
            DispatchQueue.main.async {
                self.items.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
        })
    }
    
    //Function Section
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: IndexPath?) {
        
        if let ip = indexPath{
            updateTask(ip.row, text)
        }else{
        addNewTask(text)
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func getAllTasks(){
        TaskModel.getAllTasks() {
            data, response, error in
            do {
                
                if let tasks = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: Any]]{
                    for task in tasks {
                        if let taskObj = taskInfo.init(dict: task){
                            
                            DispatchQueue.main.async{
                                self.items.append(taskObj)
                                self.tableView.reloadData()
                               
                            }
                        }
                    }
                    
                }
                
            } catch {
                print("Something went wrong")
            }
        }
    }
    func addNewTask(_ text: String){
        TaskModel.addTaskWithObjective(objective: text, completionHandler: {
            data, response, error in
            
            do{
                if let tasks = try JSONSerialization.jsonObject(with: data!) as? [String: Any]{
                    
                        if let taskObj = taskInfo.init(dict: tasks){
                         
                            DispatchQueue.main.async{
                                self.items.append(taskObj)
                                self.tableView.reloadData()
                            }
                        }
                }
                
            }catch{
                print(error)
                
            }
        })
    }
    
                                       
    func updateTask(_ ip: Int, _ text:String ){
        TaskModel.updateTask(id: ip, objective: text , completionHandler: {
            data, response, error in
            
            do{
                if let tasks = try JSONSerialization.jsonObject(with: data!) as? [String: Any]{
                    
                        if let taskObj = taskInfo.init(dict: tasks){
                         
                            DispatchQueue.main.async{
                                self.items.append(taskObj)
                                self.tableView.reloadData()
                            }
                        }
                }
                
                
                
            }catch{
                print(error)
            }
        })

    }
  
                                       
}


















