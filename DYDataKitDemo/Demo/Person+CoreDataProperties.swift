//
//  Person+CoreDataProperties.swift
//  DYDataKitDemo
//
//  Created by yexiaocheng on 2016/11/2.
//  Copyright © 2016年 dropperY. All rights reserved.
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person");
    }

    @NSManaged public var age: Int32
    @NSManaged public var name: String?
    @NSManaged public var uid: Int32

}
