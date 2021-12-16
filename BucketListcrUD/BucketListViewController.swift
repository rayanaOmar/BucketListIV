//
//  ViewController.swift
//  BucketListcrUD
//
//  Created by admin on 14/12/2021.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController , AddItemTableViewControllerDelegate {
    
    
    
    var items = [BucketListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchAllItems()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: IndexPath?) {
        if let ip = indexPath {
            let item = items[ip.row]
            item.text = text
        }else{
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
        }
        do{
           try managedObjectContext.save()
        }catch{
            print("\(error)")
        }
        
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
    
    dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell" ,for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text!
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
            addItemTableController.item = item1.text!
            addItemTableController.indexPath = indexPath
            
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "EditItemSegue", sender: indexPath
        print("Selected")
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        }catch{
            print("\(error)")
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        
        do{
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        }
        catch{
            print("\(error)")
        }
        
    }
}


















