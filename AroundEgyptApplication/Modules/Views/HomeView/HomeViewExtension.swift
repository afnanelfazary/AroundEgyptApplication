//
//  HomeViewExtension.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 06/04/2023.
//

import Foundation
import UIKit
import SwiftUI
import Kingfisher
extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UISearchBarDelegate , UISearchResultsUpdating {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching && searchingRecommended {
            
            return homeViewModel.searchList.count
        }
         else  if  searching && searchingMostRecent {
                return homeViewModel.mostRecentSearchList.count
        }

        else if searching == false
        {
            
            switch reachability.connection {
                // INternet
            case .wifi , .cellular:
                if collectionView == recommendedCollectionView {
                    return homeViewModel.recommendedList.count
                }
                else if collectionView == mostRecentCollectionView
                {
                    return homeViewModel.mostRecentList.count
                }
                break
            case .unavailable , .none:
                if collectionView == recommendedCollectionView
                {
                    
                    return   homeViewModel.recommendedItemsCoreDataArr.count
                }
                else if collectionView == mostRecentCollectionView
                {
                    return homeViewModel.mostRecentItemsCoreDataArr.count
                }
                break
            }}
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == recommendedCollectionView {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedItem", for: indexPath) as! RecommendedCollectionViewCell
            item.recommendedRoundView.layer.cornerRadius = 13
            
            if searching && searchingRecommended{
                item.experienceNameLabel.text = homeViewModel.searchList[indexPath.row].title ?? ""
                item.viewsNumLabel.text = "\(homeViewModel.searchList[indexPath.row].views_no ?? 1)"
                item.likeNumLabel.text = "\(homeViewModel.searchList[indexPath.row].likes_no ?? 1)"
                
                let recommendsImageUrl = URL( string: homeViewModel.searchList[indexPath.row].cover_photo ??  "1")
                let processor = RoundCornerImageProcessor(cornerRadius: 9)
                if (recommendsImageUrl != nil)
                {
                    item.recommendedImageView.kf.setImage(with: recommendsImageUrl, placeholder: UIImage(named: "1"),options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .cacheOriginalImage
                    ], progressBlock: nil, completionHandler: nil)
                    
                }
            }
            else
            {
                switch reachability.connection {
                    // INternet
                case .wifi , .cellular:
                    item.experienceNameLabel.text = homeViewModel.recommendedList[indexPath.row].title  ?? ""
                    item.viewsNumLabel.text = "\(homeViewModel.recommendedList[indexPath.row].views_no ?? 1)"
                    item.likeNumLabel.text = "\(homeViewModel.recommendedList[indexPath.row].likes_no ?? 1)"
                    
                    let recommendsImageUrl = URL( string: homeViewModel.recommendedList[indexPath.row].cover_photo ??  "1")
                    let processor = RoundCornerImageProcessor(cornerRadius: 9)
                    if (recommendsImageUrl != nil)
                    {
                        item.recommendedImageView.kf.setImage(with: recommendsImageUrl, placeholder: UIImage(named: "1"),options: [
                            .processor(processor),
                            .scaleFactor(UIScreen.main.scale),
                            .cacheOriginalImage
                        ], progressBlock: nil, completionHandler: nil)
                        
                    }
                    break
                case .unavailable , .none:
                    item.experienceNameLabel.text =   homeViewModel.recommendedItemsCoreDataArr[indexPath.row].value(forKey: "title") as? String
                    item.viewsNumLabel.text = "\(homeViewModel.recommendedItemsCoreDataArr[indexPath.row].value(forKey: "views_no") ?? 1)"
                    item.likeNumLabel.text = "\(homeViewModel.recommendedItemsCoreDataArr[indexPath.row].value(forKey: "likes_no") ?? 1 )"
                    let recommendsImage = (homeViewModel.recommendedItemsCoreDataArr[indexPath.row].value(forKey: "cover_photo")) as? String ?? "1"
                    let recommendsImageUrl = URL( string: recommendsImage)
                    let processor = RoundCornerImageProcessor(cornerRadius: 9)
                    if (recommendsImageUrl != nil)
                    {
                        item.recommendedImageView.kf.setImage(with: recommendsImageUrl, placeholder: UIImage(named: "1"),options: [
                            .processor(processor),
                            .scaleFactor(UIScreen.main.scale),
                            .cacheOriginalImage
                        ], progressBlock: nil, completionHandler: nil)
                        
                    }
                    break
                }}
            return item
        }
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "mostRecentItem", for: indexPath) as! MostRecentCollectionViewCell
        if searching  && searchingMostRecent {
            item.experienceNameLabel.text = homeViewModel.mostRecentSearchList[indexPath.row].title ?? ""
            item.viewsNumLabel.text = "\( homeViewModel.mostRecentSearchList[indexPath.row].views_no ?? 1)"
            item.LikesNumLabel.text = "\(homeViewModel.mostRecentSearchList[indexPath.row].likes_no ?? 1)"
            
            let mostRecentsImageUrl = URL( string: homeViewModel.mostRecentSearchList[indexPath.row].cover_photo ??  "1")
            let processor = RoundCornerImageProcessor(cornerRadius: 9)
            
            if (mostRecentsImageUrl != nil)
            {
                
                item.rexperienceImage.kf.setImage(with: mostRecentsImageUrl, placeholder: UIImage(named: "1"),options: [
                    .scaleFactor(UIScreen.main.scale),
                    .processor(processor),
                    .cacheOriginalImage
                ], progressBlock: nil, completionHandler: nil)
                
            }
        }
        else
        {
            switch reachability.connection {
                // INternet
            case .wifi , .cellular:
                item.experienceNameLabel.text = homeViewModel.mostRecentList[indexPath.row].title
                item.viewsNumLabel.text = "\( homeViewModel.mostRecentList[indexPath.row].views_no ?? 1)"
                item.LikesNumLabel.text = "\(homeViewModel.mostRecentList[indexPath.row].likes_no ?? 1)"
                
                let mostRecentsImageUrl = URL( string: homeViewModel.mostRecentList[indexPath.row].cover_photo ??  "1")
                let processor = RoundCornerImageProcessor(cornerRadius: 9)
                
                if (mostRecentsImageUrl != nil)
                {
                    
                    item.rexperienceImage.kf.setImage(with: mostRecentsImageUrl, placeholder: UIImage(named: "1"),options: [
                        .scaleFactor(UIScreen.main.scale),
                        .processor(processor),
                        .cacheOriginalImage
                    ], progressBlock: nil, completionHandler: nil)
                    
                }
            case .unavailable , .none:
                item.experienceNameLabel.text = homeViewModel.mostRecentItemsCoreDataArr[indexPath.row].value(forKey: "title") as? String
                item.viewsNumLabel.text = "\(homeViewModel.mostRecentItemsCoreDataArr[indexPath.row].value(forKey: "views_no") ?? 1)"
                item.LikesNumLabel.text = "\(homeViewModel.mostRecentItemsCoreDataArr[indexPath.row].value(forKey: "likes_no") ?? 1)"
                let recommendsImage = (homeViewModel.mostRecentItemsCoreDataArr[indexPath.row].value(forKey: "cover_photo")) as? String ?? "1"
                let recommendsImageUrl = URL( string: recommendsImage)
                let processor = RoundCornerImageProcessor(cornerRadius: 9)
                if (recommendsImageUrl != nil)
                {
                    item.rexperienceImage.kf.setImage(with: recommendsImageUrl, placeholder: UIImage(named: "1"),options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .cacheOriginalImage
                    ], progressBlock: nil, completionHandler: nil)
                    
                }
            }}
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 392, height: 181)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mySwiftUIView = SingleExperienceSwiftUIView( )
        
        let hostingController = UIHostingController(rootView: mySwiftUIView)
        if collectionView == recommendedCollectionView{
            switch reachability.connection {
                // INternet
            case .wifi , .cellular:
                let experienceId = homeViewModel.recommendedList[indexPath.row].id!
                mySwiftUIView.singleExperienceViewModel.Id = experienceId
            case .unavailable , .none:
                
                mySwiftUIView.singleExperienceViewModel.experienceName = homeViewModel.recommendedItemsCoreDataArr[indexPath.row].value(forKey: "title") as? String
                likesNum = homeViewModel.mostRecentItemsCoreDataArr[indexPath.row].value(forKey: "likes_no") as! Int
                viewsNum = homeViewModel.mostRecentItemsCoreDataArr[indexPath.row].value(forKey: "views_no") as! Int
                mySwiftUIView.singleExperienceViewModel.LikeNum = String(likesNum)
                mySwiftUIView.singleExperienceViewModel.viewsNum = String(viewsNum)
                mySwiftUIView.singleExperienceViewModel.description = homeViewModel.recommendedItemsCoreDataArr[indexPath.row].value(forKey: "descriptions") as? String
                mySwiftUIView.singleExperienceViewModel.cover_photo = homeViewModel.recommendedItemsCoreDataArr[indexPath.row].value(forKey: "cover_photo") as? String
                
                
                
                
            }
        }
        else if collectionView == mostRecentCollectionView{
            
            
            switch reachability.connection {
                // INternet
            case .wifi , .cellular:
                let experienceId = homeViewModel.mostRecentList[indexPath.row].id!
                mySwiftUIView.singleExperienceViewModel.Id = experienceId
            case .unavailable , .none:
                
                mySwiftUIView.singleExperienceViewModel.experienceName = homeViewModel.mostRecentItemsCoreDataArr[indexPath.row].value(forKey: "title") as? String
                likesNum   = homeViewModel.mostRecentItemsCoreDataArr[indexPath.row].value(forKey: "likes_no") as! Int
                viewsNum  = homeViewModel.mostRecentItemsCoreDataArr[indexPath.row].value(forKey: "views_no") as! Int
                mySwiftUIView.singleExperienceViewModel.LikeNum = String(likesNum)
                mySwiftUIView.singleExperienceViewModel.viewsNum = String(viewsNum)
                mySwiftUIView.singleExperienceViewModel.description = homeViewModel.mostRecentItemsCoreDataArr[indexPath.row].value(forKey: "descriptions") as? String
                mySwiftUIView.singleExperienceViewModel.cover_photo = homeViewModel.mostRecentItemsCoreDataArr[indexPath.row].value(forKey: "cover_photo") as? String
            }}
        navigationController?.pushViewController(hostingController, animated: true)
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty
        {
            searching = true
            homeViewModel.searchList.removeAll()
            homeViewModel.mostRecentSearchList.removeAll()
       
                
                for recommendItem in homeViewModel.recommendedList
                {
                
                    if   recommendItem.title!.lowercased().contains(searchText.lowercased())
                    {
                        searchingMostRecent = false

                        searchingRecommended = true

                        homeViewModel.searchList.append(recommendItem)
                    }
                }
                for mostItem in homeViewModel.mostRecentList
                {
                 
                    if   mostItem.title!.lowercased().contains(searchText.lowercased())
                    {
                        searchingRecommended = false

                        searchingMostRecent = true
                        homeViewModel.mostRecentSearchList.append(mostItem)
                    }
                }
                renderRecommendedCollection()
                renderMostRecentCollection()
            
            
        }
        else
        {
            searching = false
            homeViewModel.searchList.removeAll()
            homeViewModel.searchList = homeViewModel.recommendedList
            homeViewModel.searchList = homeViewModel.mostRecentList
            renderRecommendedCollection()
            renderMostRecentCollection()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        homeViewModel.searchList.removeAll()
        homeViewModel.mostRecentSearchList.removeAll()

        renderRecommendedCollection()
        renderMostRecentCollection()
    }
    
}

