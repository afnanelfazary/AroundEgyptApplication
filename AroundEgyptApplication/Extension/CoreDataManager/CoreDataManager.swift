//
//  CoreDataServices.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 06/04/2023.
//

import Foundation
import CoreData
import UIKit


protocol  CoreDataProtocol {
   static func insertItem(item:ItemCoreData)
    static func insertAllItemsToCoreData(coreDataArr:[ItemCoreData])
    static func fetchAllItems()->[NSManagedObject]
    static func findItem(itemName:String) -> ItemCoreData?
}
let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class CoreDataManager : CoreDataProtocol {
    
    static func insertAllItemsToCoreData(coreDataArr: [ItemCoreData]) {
        let entity = NSEntityDescription.entity(forEntityName: "ExperienceList", in: managedObjectContext)
        //create the row,Object,Record
        let itemRecordContext = NSManagedObject(entity:entity!, insertInto: managedObjectContext)
        for item in coreDataArr {
            
            itemRecordContext.setValue(item.title, forKey :"title")
            itemRecordContext.setValue(item.likes_no, forKey :"likes_no")
            itemRecordContext.setValue(item.views_no, forKey :"views_no")
            itemRecordContext.setValue(item.cover_photo, forKey :"coverPhoto")
            itemRecordContext.setValue(item.descriptions, forKey :"descriptions")
        }
        do {
            try managedObjectContext.save()
               print("Success")
           } catch   let error as NSError{
               print("Error saving: \(error.localizedDescription)")
           }
    }
    
    

    static func insertItem(item: ItemCoreData) {
 
        let entity = NSEntityDescription.entity(forEntityName: "ExperienceList", in: managedObjectContext)
        //create the row,Object,Record
        let itemRecordContext = NSManagedObject(entity:entity!, insertInto: managedObjectContext)
        
        itemRecordContext.setValue(item.title, forKey :"title")
        itemRecordContext.setValue(item.likes_no, forKey :"likes_no")
        itemRecordContext.setValue(item.views_no, forKey :"views_no")
        itemRecordContext.setValue(item.cover_photo, forKey :"cover_photo")
        itemRecordContext.setValue(item.descriptions, forKey :"descriptions")
        do
        {
            try managedObjectContext.save()
            print("Record is Saved")
        }
           catch  let error as NSError
           {
               print(error.localizedDescription)
           }
           
       }
    
    static func fetchAllItems() -> [NSManagedObject] {
        var itemsArr  = [NSManagedObject]()
        // create the query
        let query = NSFetchRequest<NSManagedObject>(entityName: "ExperienceList")

        do
        {
            itemsArr = try managedObjectContext.fetch(query)
            //           for row in results
            //            {
            //                let itemId = row.value(forKey: "id") as? String
            //                let itemTitle = row.value(forKey: "title") as? String
            //                let likes_no = row.value(forKey: "likes_no") as? Int
            //               let views_no = row.value(forKey: "views_no") as? Int
            //               let descriptions = row.value(forKey: "descriptions") as? String
            //               let coverPhoto = row.value(forKey: "coverPhoto") as? String
            
            //  let itemsList = ItemCoreData(id: itemId!, title: itemTitle!, coverPhoto: coverPhoto!, likes_no: likes_no!, views_no: views_no!, descriptions: descriptions!)
        //}
            return itemsArr
             }
        
        catch  let error as NSError
        {
            print(error.localizedDescription)
        }
        return itemsArr
    }
    
    static func findItem(itemName: String) -> ItemCoreData? {
   var item :ItemCoreData?
     //create Predicate
    let search = NSPredicate(format: "title = %@", itemName)
    // create the query
    let query = NSFetchRequest<NSManagedObject>(entityName: "ExperienceList")
    query.predicate = search
            do
            {
                let results = try managedObjectContext.fetch(query)
                if results.count > 0
                {
                    let row = results[0]
                    let itemId = row.value(forKey: "id") as? String
                    let itemTitle = row.value(forKey: "title") as? String
                    let likes_no = row.value(forKey: "likes_no") as? Int
                   let views_no = row.value(forKey: "views_no") as? Int
                   let descriptions = row.value(forKey: "descriptions") as? String
                   let cover_photo = row.value(forKey: "cover_photo") as? String
 
                item = ItemCoreData(id: itemId! , title: itemTitle!, cover_photo: cover_photo!, likes_no: likes_no!, views_no: views_no!, descriptions: descriptions!)
                   // ItemCoreData.init().title = itemTitle
                }
            }
            catch  let error as NSError
            {
                print(error.localizedDescription)
            }
            return item
        }
    

}
