//
//  UpdateToDoViewController.swift
//  Done
//
//  Created by Bart Jacobs on 19/10/15.
//  Copyright © 2015 Envato Tuts+. All rights reserved.
//

import UIKit
import CoreData

class UpdateToDoViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var record: NSManagedObject!
    var managedObjectContext: NSManagedObjectContext!
    
    // MARK: -
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = record.valueForKey("name") as? String {
            textField.text = name
        }
    }
    
    // MARK: -
    // MARK: Actions
    @IBAction func cancel(send: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func save(sender: AnyObject) {
        let name = textField.text
        
        if let isEmpty = name?.isEmpty where isEmpty == false {
            // Update Record
            record.setValue(name, forKey: "name")
            
            do {
                // Save Record
                try record.managedObjectContext?.save()
                
                // Dismiss View Controller
                navigationController?.popViewControllerAnimated(true)
                
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
