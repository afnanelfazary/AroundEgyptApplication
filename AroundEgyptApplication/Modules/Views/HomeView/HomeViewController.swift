//
//  HomeViewController.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 05/04/2023.
//

import UIKit
import Reachability
import CoreData
import SwiftUI
protocol HomeViewProtocol : AnyObject {
    
    func renderRecommendedCollection()
    func renderMostRecentCollection()
}
class HomeViewController: UIViewController , HomeViewProtocol {
    var homeViewModel : HomeViewModel!
 
    let reachability = try! Reachability()
    var searching = false
    var searchingRecommended = false
    var searchingMostRecent = false

    let searchController = UISearchController(searchResultsController: nil)
    //pass likes & vies Num To SingleExperience Screen
    var viewsNum : Int = 0
    var likesNum : Int = 0
    @IBOutlet weak var recommendedCollectionView : UICollectionView!
    @IBOutlet weak var mostRecentCollectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        homeViewModel = HomeViewModel()
 
        //search  bar
        navigationItem.searchController = searchController
        configureSearchController ()
        homeViewModel.bindResultToHomeView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderRecommendedCollection()
                self?.renderMostRecentCollection()
            }
        }
         renderMostRecentCollection()
        renderRecommendedCollection()
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
            renderMostRecentCollection()
            renderRecommendedCollection()
            homeViewModel.getRecommendedExperienceList()
            homeViewModel.getMostRecentExperienceList()
 
            //UNAnvaliabe Internet
        case .unavailable , .none:
            print("offline")
           
            homeViewModel.recommendedItemsCoreDataArr = homeViewModel.getRecommendListFromcoreData()
            homeViewModel.mostRecentItemsCoreDataArr = homeViewModel.getMostRecentListFromcoreData()
            renderMostRecentCollection()
            renderRecommendedCollection()
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
    
    @IBSegueAction func swiftUIAction(_ coder: NSCoder , sender: Any?, segueIdentifier : String?) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SingleExperienceSwiftUIView())
    }
    ///cofigure SearchBar
    func configureSearchController ()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType =  UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Place By Name"
    }
}
