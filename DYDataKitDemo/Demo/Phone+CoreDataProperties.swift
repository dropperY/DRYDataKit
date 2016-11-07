//
//  Phone+CoreDataProperties.swift
//  DYDataKitDemo
//
//  Created by yexiaocheng on 2016/11/2.
//  Copyright © 2016年 dropperY. All rights reserved.
//

import Foundation
import CoreData


extension Phone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Phone> {
        return NSFetchRequest<Phone>(entityName: "Phone");
    }

    @NSManaged public var name: String?
    @NSManaged public var system: String?
    @NSManaged public var price: String?
    @NSManaged public var pid: String?
    @NSManaged public var owner: Person?

}
