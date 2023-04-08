//
//  HomeViewExtension.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 06/04/2023.
//

import Foundation
import UIKit
import Kingfisher
import SwiftUI
extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == recommendedCollectionView {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedItem", for: indexPath) as! RecommendedCollectionViewCell
            item.recommendedRoundView.layer.cornerRadius = 13
            switch reachability.connection {
                // INternet
            case .wifi , .cellular:
                item.experienceNameLabel.text = homeViewModel.recommendedList[indexPath.row].title
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
            }
            return item
        }
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "mostRecentItem", for: indexPath) as! MostRecentCollectionViewCell
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
        }
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 392, height: 181)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mySwiftUIView = SingleExperienceSwiftUIView( )
        let hostingController = UIHostingController(rootView: mySwiftUIView)
        if collectionView == recommendedCollectionView{
            
            let experienceId = homeViewModel.recommendedList[indexPath.row].id!
            mySwiftUIView.singleExperienceViewModel.Id = experienceId
            navigationController?.pushViewController(hostingController, animated: true)
        }
        else if collectionView == mostRecentCollectionView{
            let experienceId = homeViewModel.mostRecentList[indexPath.row].id!
            mySwiftUIView.singleExperienceViewModel.Id = experienceId
            navigationController?.pushViewController(hostingController, animated: true)
            
        }
    }
    
    
}

