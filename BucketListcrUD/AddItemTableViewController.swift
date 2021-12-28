//
//  AddItemTableViewController.swift
//  BucketListcrUD
//
//  Created by admin on 14/12/2021.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    weak var delegate: AddItemTableViewControllerDelegate?
    var item: String?
    var indexPath: IndexPath?
    var itemId = 0
    var isUpdated = false
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let text = itemTextField.text!
        
        delegate?.itemSaved(by: self, with: text, at: itemId, isUpdated: isUpdated)
        
        
        
    }
    
    @IBOutlet weak var itemTextField: UITextField!
    override func viewDidLoad() {
        itemTextField.text = item 
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
