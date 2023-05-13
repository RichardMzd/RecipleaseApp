//
//  RecipeService.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 04/10/2022.
//

import Foundation
import Alamofire

class RecipeService {
    
    static let shared = RecipeService()
    
    private let session: RecipeProtocol
    
    init(session: RecipeProtocol = RecipeSession()) {
        self.session = session
    }
    
    func getRecipe(ingredients: [String], callback: @escaping (Result<AllRecipes?, ErrorAPI>) -> Void) {
        var components = URLComponents(string: "")
        components?.scheme = "https"
        components?.host = "api.edamam.com"
        components?.path = "/api/recipes/v2"
        components?.queryItems = [
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "app_id", value: RecipeAPI.app_id),
            URLQueryItem(name: "app_key", value: RecipeAPI.app_key),
            URLQueryItem(name: "q", value: ingredients.joined(separator: ","))]
        
        guard let url = components?.url else { return }
        
        session.request(url: url) { dataResponse in
            DispatchQueue.main.async { // Using DispatchQueue to update user interface
                guard let data = dataResponse.data else {
                    callback(.failure(.server))
                    return
                }
                guard dataResponse.response?.statusCode == 200 else {
                    print("error dataResponse")
                    callback(.failure(.network))
                    return
                }
                guard let dataDecoded = try? JSONDecoder().decode(AllRecipes.self, from: data) else {
                    print("error data")
                    callback(.failure(.decoding))
                    return
                }
                let recipesResponse: AllRecipes = dataDecoded
                callback(.success(recipesResponse))
            }
        }
    }
}



