//
//  CoreDataHelper.swift
//  wordgame
//
//  Created by Stelios Ioannou on 14/11/2018.
//  Copyright © 2018 Stelios Ioannou. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHelper {
    
    static var players: [NSManagedObject] = []
    
    static func save(id: Int, name: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             argumentArray: [id])

        
        
        
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 {
                // Atleast one was returned
                // In my case, I only updated the first item in results
                results?[0].setValue(name, forKey: "name")
            }
            else {
                let entity =
                            NSEntityDescription.entity(forEntityName: "Player",
                                                       in: managedContext)!
                let person = NSManagedObject(entity: entity,
                                                                                  insertInto: managedContext)
                
                        person.setValue(name, forKeyPath: "name")
                        person.setValue(0, forKeyPath: "points")
                
            }
        } catch {
            print("Fetch Failed: \(error)")
        }
        
        do {
            try managedContext.save()
         
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }
    static func showPlayers() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "id") as! NSNumber)
                print(data.value(forKey: "name") as! String)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
//    static func save(id: Int, name: String) {
//
//        guard let appDelegate =
//            UIApplication.shared.delegate as? AppDelegate else {
//                return
//        }
//
//        // 1
//        let managedContext =
//            appDelegate.persistentContainer.viewContext
//
//        // 2
//        let entity =
//            NSEntityDescription.entity(forEntityName: "Player",
//                                       in: managedContext)!
//
//        let person = NSManagedObject(entity: entity,
//                                     insertInto: managedContext)
//
//        // 3
//        person.setValue(name, forKeyPath: "name")
//        person.setValue(0, forKeyPath: "points")
//
//        // 4
//        do {
//            try managedContext.save()
//            players.append(person)
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
    }

