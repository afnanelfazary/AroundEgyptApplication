//
//  SingleExperienceViewModel.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 07/04/2023.
//
import Foundation
import UIKit
import CoreData
import SwiftUI
extension SingleExperienceSwiftUIView {
    
    @MainActor class SingleExperienceViewModel: ObservableObject
    {
        
        @Published var   Id : String?
        @Published var experienceName : String?
        @Published var viewsNum : String?
        @Published var LikeNum : String?
        @Published var description : String?
        @Published var cover_photo : String?
        @Published var likes_no : Int?
        @Published var isFav : Bool = false

        
        
        func getSignleExperience(){
            
            let apiLink :String = "https://aroundegypt.34ml.com/api/v2/experiences/\(Id ?? "")"
            
            NetworkManger.fetchData(apiLink: apiLink){
                [weak self] (data: SingleExperienceModel?) in
                self?.experienceName = data?.data.title ?? ""
                self?.LikeNum = String (data?.data.likes_no ?? 0)
                self?.description = data?.data.description ?? ""
                self?.viewsNum = String(data?.data.views_no ?? 0)
                self?.cover_photo = data?.data.cover_photo ?? ""
                
            }
        }
        
        
        func postLike() {
            likes_no = Int(LikeNum!)
            isFav = true
             let apiLink :String = "https://aroundegypt.34ml.com/api/v2/experiences/\(Id ?? "")/like"

            NetworkManger.sendRequest(url: apiLink , method: .post, parameters: likes_no!+1) { success in
                if success {
                    print(" data sent successfully!")
                } else {
                    print("Error sending  data.")
                }
            }
            
        }
    }
}
