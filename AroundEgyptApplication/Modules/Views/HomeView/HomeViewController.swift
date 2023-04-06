//
//  HomeViewController.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 05/04/2023.
//

import UIKit
import Kingfisher
protocol HomeViewProtocol : AnyObject {
    
    func renderRecommendedCollection()
    func renderMostRecentCollection()

}
class HomeViewController: UIViewController , HomeViewProtocol {
    var homeViewModel : HomeViewModel!
    @IBOutlet weak var recommendedCollectionView : UICollectionView!
    @IBOutlet weak var mostRecentCollectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendedCollectionView.delegate = self
        recommendedCollectionView.dataSource = self
        mostRecentCollectionView.delegate = self
        mostRecentCollectionView.dataSource = self
        
        self.navigationItem.hidesBackButton = true
        homeViewModel = HomeViewModel()
        homeViewModel.getRecommendedExperienceList()
        homeViewModel.getMostRecentExperienceList()
        homeViewModel.bindResultToHomeView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderRecommendedCollection()
                self?.renderMostRecentCollection()
                
            }
        }


    }
    func renderRecommendedCollection() {
        self.recommendedCollectionView.reloadData()
    }
    
    func renderMostRecentCollection() {
        self.mostRecentCollectionView.reloadData()
    }
    
 

}
extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recommendedCollectionView {
            return homeViewModel.recommendedList.count
        }
        return homeViewModel.mostRecentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == recommendedCollectionView {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedItem", for: indexPath) as! RecommendedCollectionViewCell
            item.recommendedRoundView.layer.cornerRadius = 13
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
            return item
        }
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "mostRecentItem", for: indexPath) as! MostRecentCollectionViewCell
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
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 392, height: 181)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            if collectionView == couponCollectionView{
//                UIPasteboard.general.string = viewModel.couponArr[indexPath.row].title
//                let alert = UIAlertController(title: "Coupon", message: "Coupon Copied To Clipboard", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
//                present(alert, animated: true)
//
//            }else {
//                let brandDetails = self.storyboard?.instantiateViewController(withIdentifier: "BrandDetailsVC") as! BrandDetailsVC
//
//                brandDetails.brandID = viewModel.result[indexPath.row].id!
//                 self.navigationController?.pushViewController(brandDetails, animated: true)
//             }
        }
}

