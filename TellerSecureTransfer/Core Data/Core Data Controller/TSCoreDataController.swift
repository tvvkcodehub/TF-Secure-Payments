//
//  TSCoreDataController.swift
//  TellerSecureTransfer
//
//  Created by Vamsi Krishna Tirumala on 20/02/21.
//

import UIKit
import CoreData

final class TSCoreDataController: NSObject {

    // MARK: - Properties
    private var modalName : String = ""
    
    init(modalname : String) {
        self.modalName = modalname
    }
    
    // MARK: - CoreData Stack
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modalName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "\(self.modalName).sqlite"
        
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
    
    // MARK: - Shared Instance
    class var shared: TSCoreDataController {
        let instance: TSCoreDataController = TSCoreDataController(modalname: COREDATA_MODAL_NAME)
        return instance
    }
    
    // MARK: - Core Data Operations
    
    // MARK: - GET NEW ID FOR ANY CORE DATA ENTITY WHICH IS A PRIMARY KEY FOR THAT ENTITY.
    func getNewRecordIdForEntity(_ entity : String) -> NSInteger {
        
        var recordsCount = 0
        let entitiesFetch =  NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do {
            let fetchedEmployees = try self.managedObjectContext.fetch(entitiesFetch)
            recordsCount = fetchedEmployees.count
        } catch {
            fatalError("Failed to fetch: \(error)")
        }
        return recordsCount
    }
    
    // MARK: - Save User in Local DB
    func InsertUser(_userModel: String, with userData: TSUser) -> Bool {
        var isSaved = false
        let entity = NSEntityDescription.insertNewObject(forEntityName: _userModel, into: self.managedObjectContext)
        guard let entityModel = entity as? User else {
            return false
        }
        
        entityModel.userId = Int32(getNewRecordIdForEntity(ENTITY_USER))
        entityModel.userName = userData.userName
        entityModel.password = userData.password
        entityModel.phoneNumber = userData.phoneNumber
        entityModel.email = userData.email
        entityModel.dataOfBirth = userData.dob
        
        do {
            try self.managedObjectContext.save()
            isSaved = true
        } catch let error {
            print("Failure to save context: \(error)")
            isSaved = false
        }
        
        return isSaved
    }
    
    // MARK: - Save User in Local DB
    func validateUser(userName: String, password: String) -> Bool {
        
        var userdata = [User]()
        var isAuthenticate = false

        let entitiesToFetch = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_USER)
        let predicate = NSPredicate(format: "userName = %@ && password = %@", userName, password)
        entitiesToFetch.predicate = predicate
        
        do {
            userdata = try self.managedObjectContext.fetch(entitiesToFetch) as NSArray as! [User]
            if userdata.count > 0 {
                isAuthenticate = true
            }
        } catch {
            fatalError("Failed to fetch: \(error)")
        }
        return isAuthenticate
    }
}
