//
//  DRManagedObject.swift
//  DYDataKitDemo
//
//  Created by yexiaocheng on 2016/11/1.
//  Copyright © 2016年 dropperY. All rights reserved.
//

import UIKit
import CoreData


public extension NSManagedObject {
    
    
    func save() {
        if (self.managedObjectContext!.hasChanges) {
            do {
                try self.managedObjectContext!.save()
            } catch {
                print(error)
            }
        }
        
    }
    
    class func create() -> Self? {
        return self.init(entity:entity(context:nil)!, insertInto:DRYManagedObjectContext.mainContext())
    }
    
    class func create(Context ctx:NSManagedObjectContext) -> Self? {
        return self.init(entity:entity(context:ctx)!, insertInto:ctx)
    }
    
    /**
        entity name of the model
     */
    class var entityName: String {
        var name = NSStringFromClass(self)
        name = name.components(separatedBy:".").last!
        print("entityName:\(name)")
        return name
    }
    
    /**
        entity
        very useful param, required in any place
     */
    class func entity(context ctx:NSManagedObjectContext?) -> NSEntityDescription? {
        if let context = ctx {
            return NSEntityDescription.entity(forEntityName:self.entityName, in:context)
        } else {
            return NSEntityDescription.entity(forEntityName:self.entityName, in:DRYManagedObjectContext.mainContext())
        }
    }
    
}

public class DRYManagedObject:NSManagedObject {
    init() {
        let entity : NSEntityDescription = type(of: self).entity(context: nil)!
        super.init(entity:entity, insertInto:DRYManagedObjectContext.mainContext())
    }
    
    init(context: NSManagedObjectContext?) {
        let entity : NSEntityDescription = type(of: self).entity(context: context)!
        super.init(entity:entity, insertInto:context)
    }
    
}


