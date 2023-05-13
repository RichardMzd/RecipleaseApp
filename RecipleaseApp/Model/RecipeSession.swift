//
//  RecipeSession.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 10/10/2022.
//

import Foundation
import Alamofire


protocol RecipeProtocol {
    func request(url: URL, callBack: @escaping (AFDataResponse<Data>) -> Void)
}

class RecipeSession: RecipeProtocol {
    
    func request(url: URL, callBack callback: @escaping (AFDataResponse<Data>) -> Void) {
        AF.request(url).responseDecodable(completionHandler: { dataResponse in
            callback(dataResponse)
        }
    )}
}

