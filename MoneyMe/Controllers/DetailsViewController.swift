//
//  DetailsViewController.swift
//  MoneyMe
//
//  Created by Eli Mehaudy on 28/10/2020.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    var manager = ItemManager()
    var selectedItem: Item? {
        didSet{
            DispatchQueue.main.async {
                self.showItemDetails()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showItemDetails() {
        if let selectedItemUnwrapped = selectedItem {
            titleLabel.text = selectedItemUnwrapped.title
            sumLabel.text = String(selectedItemUnwrapped.sum)
            detailsLabel.text = selectedItemUnwrapped.details
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        manager.deleteItem(selectedItem!)
        performSegue(withIdentifier: "goBack", sender: sender)
    }
    
}


