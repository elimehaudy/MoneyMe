//
//  DetailsViewController.swift
//  MoneyMe
//
//  Created by Eli Mehaudy on 28/10/2020.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var sumTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIButton!
    
    let realm = try! Realm()
    var manager = ItemManager()
    var selectedItem: Item? {
        didSet{
            DispatchQueue.main.async {
                self.showItemDetails()
            }
        }
    }
    var keyForValueToBeChanged = ""
    var changedTextField = ""
    var valueWasChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        sumTextField.delegate = self
        detailsTextField.delegate = self
    }
    
    func showItemDetails() {
        if let selectedItemUnwrapped = selectedItem {
            titleTextField.text = selectedItemUnwrapped.title
            sumTextField.text = String(selectedItemUnwrapped.sum)
            detailsTextField.text = selectedItemUnwrapped.details
        }
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        editBarButton.isEnabled = false
        doneButton.isHidden = false
        doneButton.isEnabled = true
        editEnabled(textField: titleTextField)
        editEnabled(textField: sumTextField)
        editEnabled(textField: detailsTextField)
    }
    
    
    func editEnabled(textField: UITextField) {
        textField.isUserInteractionEnabled = true
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.addTarget(self, action: #selector(DetailsViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        valueWasChanged = true
        if textField.tag == 1 {
            keyForValueToBeChanged = "title"
        } else if textField.tag == 2 {
            keyForValueToBeChanged = "sum"
        } else if textField.tag == 3 {
            keyForValueToBeChanged = "details"
        }
        changedTextField = textField.text!
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        if valueWasChanged {
            manager.updateItem(item: selectedItem!, newValue: changedTextField, selectedKey: keyForValueToBeChanged)
        }
        self.performSegue(withIdentifier: "goBack", sender: sender)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Deletion Message", message: "Are you sure you want to delete this item?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        let action = UIAlertAction(title: "Delete", style: .destructive) { (alertAction) in
            self.manager.deleteItem(self.selectedItem!)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        //        self.performSegue(withIdentifier: "goBack", sender: sender)
    }
    
}


