//
//  ViewController.swift
//  BucketListcrUD
//
//  Created by admin on 14/12/2021.
//

import UIKit

class BucketListViewController: UITableViewController , AddItemTableViewControllerDelegate {
    
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath {
            items[ip.row] = text
        }else{
            items.append(text)
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
    
    dismiss(animated: true, completion: nil)
    }
    
    

    var items = ["Go to the moon ",  "Eat a candy bar", "Swim in the Amazon"]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell" ,for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue"{
        let navigationController = segue.destination as! UINavigationController
        
        let addItemTableController = navigationController.topViewController as! AddItemTableViewController
        
        addItemTableController.delegate = self
        }else if segue.identifier == "EditItemSegue"{
            let navigationController = segue.destination as! UINavigationController
            
            let addItemTableController = navigationController.topViewController as! AddItemTableViewController
            
            addItemTableController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item1 = items[indexPath.row]
            addItemTableController.item = item1
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
        items.remove(at: indexPath.row)
        tableView.reloadData()
        
    }

}
