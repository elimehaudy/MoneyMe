//
//  EditorController.swift
//  MoneyMe
//
//  Created by Eli Mehaudy on 23/10/2020.
//

import UIKit
import RealmSwift

class EditorViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var sumField: UITextField!
    @IBOutlet weak var detailsField: UITextView!
    var isPositive = true

    var manager = ItemManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.delegate = self
        sumField.delegate = self
        detailsField.delegate = self
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let title = titleField.text
        let sum = Int(sumField.text!)
        let details = detailsField.text
        let newItem = manager.createItem(title: title!, sum: sum!, details: details!)
        if !isPositive {
            newItem.sum *= -1
        }
        
        manager.saveItem(item: newItem)
        performSegue(withIdentifier: "goBack", sender: self)
    }
}
