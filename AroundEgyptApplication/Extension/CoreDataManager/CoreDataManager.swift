//
//  CoreDataServices.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 06/04/2023.
//

import Foundation
import CoreData
import UIKit
import Alamofire

protocol  CoreDataProtocol {
    static func getRecommendListFromcoreData ()->[NSManagedObject]
    static  func getMostRecentListFromcoreData ()->[NSManagedObject]

 }

let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class CoreDataManager : CoreDataProtocol {
    
static func getRecommendListFromcoreData ()->[NSManagedObject]
    {
       // var context :NSManagedObjectContext?
        var arr: [NSManagedObject]? = [NSManagedObject]()
     //   let appDelgate = UIApplication.shared.delegate as! AppDelegate
       // context = appDelgate.persistentContainer.viewContext
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "RecommendedExperienceList")
        arr  = try? managedObjectContext.fetch(fetchReq)
        return arr  ?? []
    }
  static func getMostRecentListFromcoreData ()->[NSManagedObject]
    {
     //   var context :NSManagedObjectContext?
       var arr: [NSManagedObject]? = [NSManagedObject]()
  //      let appDelgate = UIApplication.shared.delegate as! AppDelegate
    //    context = appDelgate.persistentContainer.viewContext
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "MostRecentExperienceList")
        arr  = try? managedObjectContext.fetch(fetchReq)
        return arr  ?? []
    }
    
    }
    
 
