//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 30/09/2022.
//

import Foundation
import UIKit
import CoreData

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet private weak var foodImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var likeLabel: UILabel!
    @IBOutlet private weak var webPageButton: UIButton!
    @IBOutlet private weak var ingredients: UITextView!
    @IBOutlet private weak var favorite: UIBarButtonItem!
    
    // MARK: - Properties
     
     var selectedHit: Hit?
     var searchResults: RecipeData?
     var coreDataManager: DataManager?
     
     var coloredFilledStarImage: UIImage {
         return UIImage(systemName: "star.fill")!.withTintColor(.greenRecipe, renderingMode: .alwaysOriginal)
     }
     
     var unfilledStarImage: UIImage {
         return UIImage(systemName: "star")!
     }
     
     // MARK: - Lifecycle methods
     
     override func viewDidLoad() {
         super.viewDidLoad()
         setupCoreData()
         configureRecipeView()
         setupAccessibility()
     }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         updateFavoriteIcon()
     }
     
     // MARK: - Actions
     
     @IBAction func getDirectionsButtonTapped(_ sender: UIButton) {
         if let urlString = selectedHit?.recipe.url ?? searchResults?.url, let url = URL(string: urlString) {
             UIApplication.shared.open(url)
         }
     }
     
     @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
         
         if let recipeLabel = selectedHit?.recipe.label ?? searchResults?.label {
             if coreDataManager?.recipeAlreadySaved(label: recipeLabel) == true {
                 deleteRecipe()
                 toggleFavorite(isFavorite: false)
                 if tabBarController?.selectedIndex == 1 {
                     navigationController?.popViewController(animated: true)
                 }
             } else {
                 saveRecipe()
                 toggleFavorite(isFavorite: true)
             }
         }
     }
     
     // MARK: - Private methods
     
     func toggleFavorite(isFavorite: Bool) {
         favorite.image = isFavorite ? coloredFilledStarImage : unfilledStarImage
     }
     
     private func updateFavoriteIcon() {
         let label = selectedHit?.recipe.label ?? searchResults?.label ?? ""
         favorite.image = coreDataManager?.recipeAlreadySaved(label: label) == true ? coloredFilledStarImage : unfilledStarImage
     }
     
    private func configureRecipeView() {
            if selectedHit != nil {
                guard let ingredientLines = selectedHit?.recipe.ingredientLines.joined(separator: "\n" + "- ") else { return }
                guard let imageDish = URL(string: selectedHit?.recipe.image ?? "recipeSet image") else { return }
                foodImage.downloaded(from: imageDish)
                ingredients.text = "- " + ingredientLines
                titleLabel.text = selectedHit?.recipe.label.localizedCapitalized
                likeLabel.text = "\(Int(selectedHit?.recipe.yield ?? 0))"
                timeLabel.text = (selectedHit?.recipe.totalTime ?? 0).convertInt
            } else {
                guard let ingredientLines = searchResults?.ingredientsLines.joined(separator: "\n" + "- ") else { return }
                guard let imageDish = URL(string: searchResults?.image ?? "recipeSet image") else { return }
                foodImage.downloaded(from: imageDish)
                ingredients.text = "- " + ingredientLines
                titleLabel.text = searchResults?.label.localizedCapitalized
                likeLabel.text = "\(Int(searchResults?.yield ?? 0))"
                timeLabel.text = (searchResults?.totalTime ?? 0).convertInt
            }
        }
     
     private func saveRecipe() {
         guard let label = selectedHit?.recipe.label,
               let image = selectedHit?.recipe.image,
               let yield = selectedHit?.recipe.yield,
               let totalTime = selectedHit?.recipe.totalTime,
               let ingredientsLines = selectedHit?.recipe.ingredientLines,
               let url = selectedHit?.recipe.url else { return }
         
         coreDataManager?.saveRecipe(label: label, image: image, yield: yield, totalTime: totalTime, ingredientsLines: ingredientsLines, url: url)
     }
    
    private func deleteRecipe() {
           let label = selectedHit?.recipe.label ?? searchResults?.label ?? ""
           coreDataManager?.deleteRecipe(label: label)
       }
       
       private func setupCoreData() {
           guard coreDataManager == nil,
                 let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           
           let coreDataStack = appDelegate.coreDataStack
           coreDataManager = DataManager(coreDataStack: coreDataStack)
       }
       
       private func setupAccessibility() {
           VoiceOver.shared.voiceOver(object: titleLabel, hint: "The name of the recipe")
           VoiceOver.shared.voiceOver(object: ingredients, hint: "List of ingredients")
       }
}

