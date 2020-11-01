//
//  ItemManager.swift
//  MoneyMe
//
//  Created by Eli Mehaudy on 28/10/2020.
//

import Foundation
import RealmSwift

struct ItemManager {
    
    let realm = try! Realm()
    var items: Results<Item>?
    
    func createItem(title: String, sum: Int, details: String) -> Item {
        let newItem = Item()
        newItem.title = title
        newItem.sum = sum
        newItem.details = details
        
        return newItem
    }
    
    func saveItem(item: Item) {
        do {
            try realm.write {
                realm.add(item)
            }
            
        } catch {
            print("Error saving item, \(error)")
        }
    }
    
    func updateItem(item: Item, newValue: String, selectedKey: String) {
        try! realm.write{
            item.setValue(newValue, forKey: selectedKey)
        }
    }
    
    mutating func loadItems() {
        items = realm.objects(Item.self)
    }
    
    func deleteItem(_ item: Item) {
        do{
            try realm.write{
                realm.delete(item)
            }
        } catch {
            print("Error deleting item, \(error)")
        }
    }
    
    func calculateBalance() -> Int {
        var totalBalance = 0
        
        if items != nil {
            for item in items! {
                totalBalance += item.sum
            }
        }
        return totalBalance
    }
}
