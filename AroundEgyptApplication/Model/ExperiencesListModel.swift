//
//  ExperiencesListModel.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 05/04/2023.
//

import Foundation
class ExperiencesListModel : Decodable {
    var meta: MetaModel
    var data: [DataModel]
    
}

class SingleExperienceModel : Decodable {
    var meta: MetaModel
    var data: DataModel
    
}

class MetaModel : Decodable
{
    var code : Int
    var  errors : [Dictionary<String, String>] = []
}
class DataModel : Decodable{
 
        var  id: String?
        var title: String?
        var cover_photo: String?
        var description :String?
        var views_no :Int?
        var likes_no: Int?
        var recommended : Int?
    
    }
