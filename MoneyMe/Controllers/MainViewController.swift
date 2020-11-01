//
//  ViewController.swift
//  MoneyMe
//
//  Created by Eli Mehaudy on 21/10/2020.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalSumLabel: UILabel!
    
    var manager = ItemManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        manager.loadItems()
        reloadUI()
    }
    
    func reloadUI() {
        tableView.reloadData()
        totalSumLabel.text = String(manager.calculateBalance())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? EditorViewController {
            if segue.identifier == "negativeSum" {
                destinationVC.isPositive = false
            } else if segue.identifier == "positiveSum" {
                destinationVC.isPositive = true
            }
        } else {
            let destinationVC = segue.destination as! DetailsViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedItem = manager.items![indexPath.row]
            }
        }
    }
    
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.reloadUI()
            }
        }
    }

    //MARK: - UITableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.items?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        updateCell(cell, at: indexPath)
        return cell
    }
    
    func updateCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        cell.textLabel?.text = manager.items?[indexPath.row].title ?? "No Items added yet"
        displaySumInDetailLabel(cell: cell, indexPath: indexPath)
    }
    
    func displaySumInDetailLabel(cell: UITableViewCell, indexPath: IndexPath) {
        if manager.items != nil {
            let sumInCell = manager.items![indexPath.row].sum
            if sumInCell > 0 {
                cell.detailTextLabel?.textColor = .systemGreen
            } else if sumInCell < 0 {
                cell.detailTextLabel?.textColor = .systemRed
            } else {
                cell.detailTextLabel?.textColor = .black
            }
            cell.detailTextLabel?.text = String(sumInCell)
        } else {
            cell.detailTextLabel?.isHidden = true
        }
    }
    
    //MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

