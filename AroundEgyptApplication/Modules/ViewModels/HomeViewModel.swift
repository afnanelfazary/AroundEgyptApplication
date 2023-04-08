//
//  HomeViewModel.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 05/04/2023.
//

import Foundation
import UIKit
import CoreData
class HomeViewModel{
    var baseURL : String = "https://aroundegypt.34ml.com"
    var recommendedFlag : Bool = false
    var bindResultToHomeView : (() -> ()) = {}
 
    
    var recommendedItemsCoreDataArr :[NSManagedObject] = [] {
        didSet{
            //bind the result
            bindResultToHomeView()
        }
    }
    var mostRecentItemsCoreDataArr :[NSManagedObject] = []{
        didSet{
            //bind the result
            bindResultToHomeView()
        }
    }
    var recommendedList : [DataModel] = []{
        didSet{
            //bind the result
            bindResultToHomeView()
        }
    }
    var mostRecentList : [DataModel] = []{
        didSet{
            //bind the result
            bindResultToHomeView()
        }
    }
    
    var searchList: [DataModel] = []{
        didSet{
        //  bind the search result
            bindResultToHomeView()
       }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func getRecommendedExperienceList(){
 
        NetworkManger.fetchData(apiLink: baseURL+apiLinks.recommendedListAPI.rawValue)
        {[weak self] (data: ExperiencesListModel?) in
                 self?.recommendedList = data?.data ?? []
            for json in self!.recommendedList {

                let entity = NSEntityDescription.insertNewObject(forEntityName: "RecommendedExperienceList", into: self!.context)
                entity.setValue(json.title, forKey: "title")
                entity.setValue(json.likes_no, forKey: "likes_no")
                entity.setValue(json.views_no, forKey: "views_no")
                entity.setValue(json.cover_photo, forKey: "cover_photo")
                entity.setValue(json.description, forKey: "descriptions")

                do {
                    try self?.context.save()
                 } catch {
                    // Handle the error
                    print(error.localizedDescription)
                }
            }
            
            
        }
 
        }
    

    
    
    
    func getMostRecentExperienceList(){
        
        NetworkManger.fetchData(apiLink: baseURL+apiLinks.mostRecentListAPI.rawValue)
        {[weak self] (data: ExperiencesListModel?) in
 
                self?.mostRecentList = data?.data ?? []
            for json in self!.mostRecentList {

                let entity = NSEntityDescription.insertNewObject(forEntityName: "MostRecentExperienceList", into: self!.context)
                entity.setValue(json.title, forKey: "title")
                entity.setValue(json.likes_no, forKey: "likes_no")
                entity.setValue(json.views_no, forKey: "views_no")
                entity.setValue(json.cover_photo, forKey: "cover_photo")
                entity.setValue(json.description, forKey: "descriptions")

                do {
                    try self?.context.save()
                 } catch {
                    // Handle the error
                    print(error.localizedDescription)
                }
            }
                        }
        }
 
   
         }
    
    
 
