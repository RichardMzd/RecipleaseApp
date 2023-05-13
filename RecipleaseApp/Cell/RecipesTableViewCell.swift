//
//  RecipesTableViewCell.swift
//  RecipleaseApp
//
//  Created by Richard Arif Mazid on 31/10/2022.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageRecipeView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var recipeSet: Recipe? {
        didSet {
            guard let imageUrl = URL(string: recipeSet?.image ?? "recipe image") else { return }
            titleLabel.text = recipeSet?.label.localizedCapitalized
            subtitleLabel.text = recipeSet?.ingredientLines.joined()
            imageRecipeView.downloaded(from: imageUrl)
            likeLabel.text = "\(Int(recipeSet?.yield ?? 0))"
            timeLabel.text = (recipeSet?.totalTime ?? 0).convertInt
        }
    }
    
//    var recipeFavorite: FavoritesRecipes? {
//        didSet {
//            guard let image = recipeFavorite?.image else { return }
//            titleLabel.text = recipeFavorite?.label
//            subtitleLabel.text = recipeFavorite?.ingredientsLines?.joined()
//            imageRecipeView.image = UIImage(named: image)
//            likeLabel.text = "\(recipeFavorite?.yield ?? 0)"
//            timeLabel.text = "\(recipeFavorite?.totalTime ?? 0)"
//        }
//    }
    
    var recipeData: RecipeData? {
           didSet {
               guard let recipeData = recipeData else { return }
               titleLabel.text = recipeData.label
               subtitleLabel.text = recipeData.ingredientsLines.joined()
               likeLabel.text = "\(recipeData.yield)"
               timeLabel.text = recipeData.totalTime.convertInt
               if let imageUrl = URL(string: recipeData.image ?? "") {
                   imageRecipeView.downloaded(from: imageUrl)
               }
           }
       }
}
