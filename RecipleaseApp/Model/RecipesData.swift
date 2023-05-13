//
//  RecipesData.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 08/03/2023.
//

import Foundation

struct RecipeData: Decodable {
    let label: String
    let image: String?
    let ingredientsLines: [String]
    let url: String
    let yield: Int
    let totalTime: Int
}
