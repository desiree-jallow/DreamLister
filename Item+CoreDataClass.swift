//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Desiree on 11/24/20.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = Date()
    }
}
