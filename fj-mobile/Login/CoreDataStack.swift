//
//  CoreDataStack.swift
//  fj-mobile
//
//  Created by Egon Fiedler on 3/18/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import CoreData


/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//CoreData, since we don't want it to be changed in any way we stablish it has public, everyone can take it
//but no one can change it
//is private to not let it change
public final class CoreDataStack {
    
    //Unchanging constant that is shared between all objects of a class
    //Is static to protect the capacity to make it constant through the whole program but still global
    static let instance = CoreDataStack()
    
    //Why is this like this??
    private init() {}
    
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(
            name: "shop_keep"
        )
        
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        let viewContext = persistentContainer.viewContext
        return viewContext
    }()
    
    lazy var privateContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return context
    }()
    
    func saveTo(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                preconditionFailure(error.localizedDescription)
            }
        }
    }
}
