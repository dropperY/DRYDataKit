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
    
    /**
      this method will save all changes
     */
    func save() {
        if (self.managedObjectContext!.hasChanges) {
            do {
                try self.managedObjectContext!.save()
            } catch {
                print(error)
            }
        }
        
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
            return NSEntityDescription.entity(forEntityName:self.entityName, in:DRYManagedObjectContext.defaultContext())
        }
    }
    
    /**
        create object
     */
    class func create() -> Self? {
        return self.create(Context: nil)
    }
    
    class func create(Context ctx:NSManagedObjectContext?) -> Self? {
        
        var context = ctx
        if context == nil {
            context = DRYManagedObjectContext.defaultContext()
        }
        
        return self.init(entity:entity(context:context)!, insertInto:context)
    }
    
    
    /**
        find object with key and value
     */
    class func find<T:NSManagedObject>(attribute key:String, with value:Any) -> T?{
        return find(attribute: key, with: value, in: nil)
    }
    
    class func find<T:NSManagedObject>(attribute key:String, with value:Any, in ctx:NSManagedObjectContext?) -> T?{
        let results : [T]? = findAll(attribute:key, with:value, in:ctx)

        return results?.first
    }
    
    class func findAll<T:NSManagedObject>(attribute key:String, with value:Any) -> [T]? {
        return findAll(attribute:key, with:value, in: nil)
    }
    
    class func findAll<T:NSManagedObject>(attribute key:String, with value:Any, in ctx:NSManagedObjectContext?) -> [T]? {
        
        let predicate = NSPredicate(format: "%K = %@", argumentArray: [key, value])
        
        var context : NSManagedObjectContext? = ctx

        if ctx == nil {
            context = DRYManagedObjectContext.defaultContext()
        }
        
        do {
            let fetchedObjects : [T] = try context!.fetch(fetchRequest(with:predicate))
            return fetchedObjects
        } catch {
            print(error)
        }
        return nil

    }
    
    /**
     find object with key and value, if not exist then create one
     */
    class func findAndCreate<T:NSManagedObject>(attribute key:String, with value:Any, in ctx:NSManagedObjectContext?) -> T? {
        if let result : T = find(attribute: key, with: value, in: ctx) {
            return result
        } else {
            var context = ctx
            if context == nil {
                context = DRYManagedObjectContext.defaultContext()
            }
            return create(Context: context) as! T?
        }
    }
    
    
    /**
     *  delete self from its context
     *  call save() to sync
     */
    func delete() {
        self.managedObjectContext?.delete(self)
    }
    
    class func fetchRequest<T: NSManagedObject>() -> NSFetchRequest<T>{
        let request = NSFetchRequest<T>(entityName: entityName)
        return request
    }
    
    class func fetchRequest<T: NSManagedObject>(with predicate:NSPredicate) -> NSFetchRequest<T>{
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        return request
    }

}

/**
 *  if inherit from DRYManagedObject
 *  we can init ManagedObject like:
 *
 *  let person : Person = Person()
 *
 */

public class DRYManagedObject:NSManagedObject {
    init() {
        let entity : NSEntityDescription = type(of: self).entity(context: nil)!
        super.init(entity:entity, insertInto:DRYManagedObjectContext.defaultContext())
    }
    
    init(context: NSManagedObjectContext?) {
        let entity : NSEntityDescription = type(of: self).entity(context: context)!
        super.init(entity:entity, insertInto:context)
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
}


