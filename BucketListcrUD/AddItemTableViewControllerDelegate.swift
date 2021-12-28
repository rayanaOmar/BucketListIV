//
//  AddItemTableViewControllerDelegate.swift
//  BucketListcrUD
//
//  Created by admin on 14/12/2021.
//

import Foundation

protocol AddItemTableViewControllerDelegate: AnyObject{
    func itemSaved(by controller: AddItemTableViewController, with text: String, at id: Int , isUpdated: Bool)
    
    func cancelButtonPressed(by controller: AddItemTableViewController)
    
}
