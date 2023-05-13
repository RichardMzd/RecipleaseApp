//
//  DataManager.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 02/03/2023.
//

import Foundation
import CoreData

final class DataManager {
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
//  MARK: - Initialization
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    var favoritesRecipes: [FavoritesRecipes] {
        let request: NSFetchRequest<FavoritesRecipes> = FavoritesRecipes.fetchRequest()
        guard let favoritesRecipes = try? managedObjectContext.fetch(request) else { return [] }
        return favoritesRecipes
    }
    
//  MARK: - Save Recipe in Favorite
    
    func saveRecipe(label: String, image: String, yield: Int, totalTime: Int, ingredientsLines: [String], url: String) {
        let favoriteRecipe = FavoritesRecipes(context: managedObjectContext)
        favoriteRecipe.label = label
        favoriteRecipe.image = image
        favoriteRecipe.yield = (Double(yield))
        favoriteRecipe.totalTime = (Double(totalTime))
        favoriteRecipe.ingredientsLines = ingredientsLines
        favoriteRecipe.url = url
        coreDataStack.saveContext()
    }
 
//  MARK: - Delete Recipes From Favorites
    
    func deleteRecipe(label: String) {
        let request: NSFetchRequest<FavoritesRecipes> = FavoritesRecipes.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        guard let favoritesRecipes = try? managedObjectContext.fetch(request) else { return }
        favoritesRecipes.forEach { (managedObjectContext.delete($0)) }
        coreDataStack.saveContext()
    }
    
//  MARK: - Recipe Already Exist in Favorite
    
    func recipeAlreadySaved(label: String) -> Bool {
        let request: NSFetchRequest<FavoritesRecipes> = FavoritesRecipes.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        
        guard let _ = try? managedObjectContext.fetch(request).first else {
            return false
        }
        return true
    }
}

