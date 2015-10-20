//
//  AddToDoViewController.swift
//  Done
//
//  Created by Bart Jacobs on 19/10/15.
//  Copyright © 2015 Envato Tuts+. All rights reserved.
//

import UIKit
import CoreData

class AddToDoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: -
    // MARK: Actions
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: AnyObject) {
        let name = textField.text
        
        if let isEmpty = name?.isEmpty where isEmpty == false {
            // Create Entity
            let entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: self.managedObjectContext)
            
            // Initialize Record
            let record = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: self.managedObjectContext)
            
            // Populate Record
            record.setValue(name, forKey: "name")
            record.setValue(NSDate(), forKey: "createdAt")
            
            do {
                // Save Record
                try record.managedObjectContext?.save()
                
                // Dismiss View Controller
                dismissViewControllerAnimated(true, completion: nil)
                
            } catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
                
                // Show Alert View
                showAlertWithTitle("Warning", message: "Your to-do could not be saved.", cancelButtonTitle: "OK")
            }
            
        } else {
            // Show Alert View
            showAlertWithTitle("Warning", message: "Your to-do needs a name.", cancelButtonTitle: "OK")
        }
    }
    
    // MARK: -
    // MARK: Helper Methods
    private func showAlertWithTitle(title: String, message: String, cancelButtonTitle: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // Configure Alert Controller
        alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .Default, handler: nil))
        
        // Present Alert Controller
        presentViewController(alertController, animated: true, completion: nil)
    }
}
