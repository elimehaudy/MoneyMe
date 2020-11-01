//
//  EditorController.swift
//  MoneyMe
//
//  Created by Eli Mehaudy on 23/10/2020.
//

import UIKit

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
        
        let titleIsFilled = checkTextField(textfield: titleField, message: "Add title")
        let sumIsFilled = checkTextField(textfield: sumField, message: "Add sum")
        if titleIsFilled && sumIsFilled {
            let newItem = manager.createItem(title: title!, sum: sum!, details: details!)
            if !isPositive {
                newItem.sum *= -1
            }
            manager.saveItem(item: newItem)
            performSegue(withIdentifier: "goBack", sender: self)
        }
    }
    
    func checkTextField(textfield: UITextField, message: String) -> Bool{
        if textfield.text == "" {
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
}
