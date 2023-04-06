//
//  HomeViewController.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 05/04/2023.
//

import UIKit
import Kingfisher
import Reachability
import CoreData
protocol HomeViewProtocol : AnyObject {
    
    func renderRecommendedCollection()
    func renderMostRecentCollection()

}
class HomeViewController: UIViewController , HomeViewProtocol {
    var homeViewModel : HomeViewModel!
    let reachability = try! Reachability()
     @IBOutlet weak var recommendedCollectionView : UICollectionView!
    @IBOutlet weak var mostRecentCollectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        homeViewModel = HomeViewModel()
        
        homeViewModel.bindResultToHomeView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderRecommendedCollection()
                self?.renderMostRecentCollection()
                
            }
        }
        switch reachability.connection {
            // INternet
        case .wifi , .cellular:
            
            homeViewModel.getRecommendedExperienceList()
            homeViewModel.getMostRecentExperienceList()
            if homeViewModel.recommendedFlag == true
            {
                homeViewModel.recommendedItemsCoreDataArr = homeViewModel.recommendedList as! [NSManagedObject]
                CoreDataManager.insertAllItemsToCoreData(coreDataArr:homeViewModel.recommendedItemsCoreDataArr as! [ItemCoreData])
            }
            else
            {
                homeViewModel.mostRecentItemsCoreDataArr = homeViewModel.mostRecentList as! [NSManagedObject]
                CoreDataManager.insertAllItemsToCoreData(coreDataArr:homeViewModel.mostRecentItemsCoreDataArr as! [ItemCoreData])
                
            }
 
            //UNAnvaliabe Internet
        case .unavailable , .none:
          homeViewModel.recommendedItemsCoreDataArr = CoreDataManager.fetchAllItems()
            homeViewModel.mostRecentItemsCoreDataArr = CoreDataManager.fetchAllItems()

            print("Nooooooo")
 
        }
        
    }
        override func viewWillAppear(_ animated: Bool) {
               NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
               do {
                   try reachability.startNotifier()
               } catch
                {
                   print("Unable to start notifier")
               }
            switch reachability.connection {
                // INternet
            case .wifi , .cellular:
                
                homeViewModel.getRecommendedExperienceList()
                homeViewModel.getMostRecentExperienceList()
                if homeViewModel.recommendedFlag == true
                {
                    homeViewModel.recommendedItemsCoreDataArr = homeViewModel.recommendedList as! [NSManagedObject]
                    CoreDataManager.insertAllItemsToCoreData(coreDataArr:homeViewModel.recommendedItemsCoreDataArr as! [ItemCoreData])
                }
                else
                {
                    homeViewModel.mostRecentItemsCoreDataArr = homeViewModel.mostRecentList as! [NSManagedObject]
                    CoreDataManager.insertAllItemsToCoreData(coreDataArr:homeViewModel.mostRecentItemsCoreDataArr as! [ItemCoreData])
                    
                }
     
                //UNAnvaliabe Internet
            case .unavailable , .none:
              homeViewModel.recommendedItemsCoreDataArr = CoreDataManager.fetchAllItems()
                homeViewModel.mostRecentItemsCoreDataArr = CoreDataManager.fetchAllItems()

                print("Nooooooo")
     
            }
           }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    // check reachabilityChanged
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
 
    }
    func renderRecommendedCollection() {
        self.recommendedCollectionView.reloadData()
    }
    
    func renderMostRecentCollection() {
        self.mostRecentCollectionView.reloadData()
    }
    
 

}
