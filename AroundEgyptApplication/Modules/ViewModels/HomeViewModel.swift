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
    var recommendedItemsCoreDataArr :[NSManagedObject] = []{
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
    func getRecommendedExperienceList(){
 
        NetworkManger.fetchData(apiLink: baseURL+apiLinks.recommendedListAPI.rawValue)
        {[weak self] (data: ExperiencesListModel?) in
                 self?.recommendedList = data?.data ?? []
            self?.recommendedFlag = true

             }
 
        }
    func getMostRecentExperienceList(){
        
        NetworkManger.fetchData(apiLink: baseURL+apiLinks.mostRecentListAPI.rawValue)
        {[weak self] (data: ExperiencesListModel?) in
 
                self?.mostRecentList = data?.data ?? []
            self?.recommendedFlag = false
            }
        }
    }
    
 
