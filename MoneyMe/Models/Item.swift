//
//  Item.swift
//  MoneyMe
//
//  Created by Eli Mehaudy on 23/10/2020.
//

import Foundation
import RealmSwift

class Item: Object{
    
    @objc dynamic var title = ""
    @objc dynamic var sum = 0
    @objc dynamic var details = ""
    var selectedItem = LinkingObjects(fromType: Parent.self, property: "itemsList")
   
}
