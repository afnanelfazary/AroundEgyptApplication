//
//  NetworkManager.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 05/04/2023.
//

import Foundation
import Alamofire

protocol NetworkMangerProtocol {
    static func fetchData<T : Decodable>( apiLink : String ,complitionHandler: @escaping (T?) -> Void)
    static  func sendRequest<T: Encodable>(url: String, method: HTTPMethod, parameters: T, completion: @escaping (Bool) -> Void)

}

class NetworkManger : NetworkMangerProtocol {
    static func fetchData<T : Decodable>(apiLink : String , complitionHandler: @escaping (T?) -> Void){
        
        AF.request(apiLink).response{
            response in
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(T.self, from: data)
                    complitionHandler(result)
                }
                catch{
                    complitionHandler(nil)
                }
            }
        }
        
    }
 static   func sendRequest<T: Encodable>(url: String, method: HTTPMethod, parameters: T, completion: @escaping (Bool) -> Void) {
           AF.request(url, method: method, parameters: parameters, encoder: JSONParameterEncoder.default)
               .validate(statusCode: 200..<300)
               .responseData { response in
                   switch response.result {
                   case .success:
                       completion(true)
                   case .failure(let error):
                       print(error.localizedDescription)
                       completion(false)
                   }
               }
       }
}
