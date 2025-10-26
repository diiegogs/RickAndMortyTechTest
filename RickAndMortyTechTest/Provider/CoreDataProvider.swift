//
//  CoreDataProvider.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 26/10/25.
//

import CoreData

class CoreDataProvider {
    let persistenceContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistenceContainer.viewContext
    }
    
    static var preview: CoreDataProvider = {
        let provider = CoreDataProvider(inMemory: true)
        let viewContext = provider.viewContext
        
        do {
            try viewContext.save()
        } catch  {
            print(error.localizedDescription)
        }
        
        return provider
    }()
    
    init(inMemory: Bool = false) {
        persistenceContainer = NSPersistentContainer(name: "CharacterModel")
        
        if inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            persistenceContainer.persistentStoreDescriptions = [description]
        }
        
        persistenceContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error: \(error.localizedDescription)")
            }
        }
    }
}
