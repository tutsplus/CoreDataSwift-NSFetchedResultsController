//
//  ToDoCell.swift
//  Done
//
//  Created by Bart Jacobs on 19/10/15.
//  Copyright © 2015 Envato Tuts+. All rights reserved.
//

import UIKit

typealias ToDoCellDidTapButtonHandler = () -> Void

class ToDoCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var didTapButtonHandler: ToDoCellDidTapButtonHandler?
    
    // MARK: -
    // MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    // MARK: -
    // MARK: View Methods
    private func setupView() {
        let imageNormal = UIImage(named: "button-done-normal")
        let imageSelected = UIImage(named: "button-done-selected")
        
        doneButton.setImage(imageNormal, forState: .Normal)
        doneButton.setImage(imageNormal, forState: .Disabled)
        doneButton.setImage(imageSelected, forState: .Selected)
        doneButton.setImage(imageSelected, forState: .Highlighted)
        doneButton.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
    }
    
    // MARK: -
    // MARK: Actions
    func didTapButton(sender: AnyObject) {
        if let handler = didTapButtonHandler {
            handler()
        }
    }
}
