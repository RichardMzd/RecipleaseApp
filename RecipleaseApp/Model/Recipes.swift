//
//  Ingredients.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 06/10/2022.
//

import Foundation

struct AllRecipes: Codable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Codable {
    var label: String
    let image: String?
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int?
}
