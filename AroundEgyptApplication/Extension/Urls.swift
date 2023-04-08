//
//  Urls.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 05/04/2023.
//

import Foundation

 enum apiLinks : String {
     case recommendedListAPI = "/api/v2/experiences?filter[recommended]=true"
    case mostRecentListAPI = "/api/v2/experiences"
     case singleExperienceAPI = "/api/v2/experiences/{id}"
    case postLikeAPI = "/api/v2/experiences/{id}/like"

 
}
