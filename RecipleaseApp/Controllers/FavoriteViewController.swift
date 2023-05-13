//
//  FavoritesViewController.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 27/09/2022.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet private weak var favoritesTableView: UITableView!
    @IBOutlet private weak var noFavoriteText: UILabel!
    
    // MARK: - Properties
    
    private let segueToRecipeDetail = "Favorite_Details"
    var recipesData: RecipeData?
    var coreDataManager: DataManager?
    var favoriteRecipes: [FavoritesRecipes]? = []
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupDataManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteRecipes()
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        view.backgroundColor = .darkGray
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "Chalkduster", size: 20) ?? (Any).self,
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupTableView() {
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
    }
    
    private func setupDataManager() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = DataManager(coreDataStack: coreDataStack)
    }
    
    private func fetchFavoriteRecipes() {
        favoriteRecipes = coreDataManager?.favoritesRecipes ?? []
        tableViewEmpty()
        favoritesTableView.reloadData()
    }
    
    private func tableViewEmpty() {
        favoritesTableView.isHidden = coreDataManager?.favoritesRecipes.isEmpty ?? true
        noFavoriteText.isHidden = !favoritesTableView.isHidden
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let recipeCell = tableView.dequeueReusableCell(withIdentifier: "RecipesResult", for: indexPath) as? RecipesTableViewCell else { return UITableViewCell() }
        
        
        let favoriteRecipe = favoriteRecipes?[indexPath.row]
        
        let recipeData = RecipeData(label: favoriteRecipe?.label ?? "",
                                    image: favoriteRecipe?.image ?? "",
                                    ingredientsLines: favoriteRecipe?.ingredientsLines ?? [],
                                    url:  favoriteRecipe?.url ?? "",
                                    yield: Int(favoriteRecipe?.yield ?? 0),
                                    totalTime: Int(favoriteRecipe?.totalTime ?? 0))
        recipeCell.recipeData = recipeData
        return recipeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(180)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedRecipe = coreDataManager?.favoritesRecipes[indexPath.row] else {
            return
        }
        recipesData = RecipeData(label: selectedRecipe.label ?? "",
                                 image: selectedRecipe.image ?? "",
                                 ingredientsLines: selectedRecipe.ingredientsLines ?? [],
                                 url: selectedRecipe.url ?? "",
                                 yield: Int(selectedRecipe.yield),
                                 totalTime: Int(selectedRecipe.totalTime))
        
        performSegue(withIdentifier: segueToRecipeDetail, sender: recipesData)
    }
}

extension FavoritesViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueToRecipeDetail {
            guard let detailRecipeVC = segue.destination as? RecipeDetailsViewController else { return }
            detailRecipeVC.searchResults = recipesData
        }
    }
}

