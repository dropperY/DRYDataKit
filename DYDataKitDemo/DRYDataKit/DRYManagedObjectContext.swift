//
//  DRYManagedObjectContext.swift
//  DYDataKitDemo
//
//  Created by yexiaocheng on 2016/11/2.
//  Copyright © 2016年 dropperY. All rights reserved.
//

import UIKit
import CoreData

class DRYManagedObjectContext: NSManagedObjectContext {
    
    override init(concurrencyType ct: NSManagedObjectContextConcurrencyType) {
        super.init(concurrencyType: ct)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static let _psc : NSPersistentStoreCoordinator = {
        let psc = NSPersistentStoreCoordinator(managedObjectModel: _objectModel)
        let options = [NSMigratePersistentStoresAutomaticallyOption : true,
                      NSInferMappingModelAutomaticallyOption : true]
        
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: _persistentStoreURL, options: options)
        } catch {
            print(error)
        }
        
       
        return psc
    }()
    
    static let _mainContext: DRYManagedObjectContext = {
        let type = NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType
        let instance = DRYManagedObjectContext(concurrencyType:type)
        instance.persistentStoreCoordinator = _psc
        
        return instance
    }()
    
    class func defaultContext() -> DRYManagedObjectContext {
        return _mainContext
    }
    
    class func mainContext() -> DRYManagedObjectContext {
        return _mainContext
    }
    
    static let _objectModel : NSManagedObjectModel = {
//        let model = NSManagedObjectModel(byMerging: nil)
//        return model!
        return NSManagedObjectModel.mergedModel(from: nil)!
    }()
    
    static let _persistentStoreURL : URL = {
        let bundle = Bundle.main
        let info = bundle.infoDictionary
        
        let paths = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        var documentsDirectory = paths[0]
        let app = info?["CFBundleDisplayName"]
        let url = documentsDirectory.appendingPathComponent("\(app).sqlite")
        return url
    }()
    
    
}
