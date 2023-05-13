//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 30/09/2022.
//

import Foundation
import UIKit

class RecipeListViewController: UIViewController {
    
//  MARK: - Outlets
    @IBOutlet private weak var listTableview: UITableView!
 
//  MARK: - Propreties
    var recipesArray: [Hit]?
    var recipesData: RecipeData?
    private var cellSelected: Hit?
    private let segueToRecipeDetail = "List_Details"

// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        self.navigationController?.navigationBar.tintColor = .white
        listTableview.delegate = self
        listTableview.dataSource = self
    }
}

extension RecipeListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recipesArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(180)
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let recipeCell = tableView.dequeueReusableCell(withIdentifier: "RecipesResult", for: indexPath) as? RecipesTableViewCell else { return UITableViewCell() }
        
        let recipe = recipesArray?[indexPath.row]
        recipeCell.recipeSet = recipe?.recipe
        return recipeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.cellSelected = recipesArray?[indexPath.row]
            tableView.reloadRows(at: [indexPath], with: .fade)
            performSegue(withIdentifier: self.segueToRecipeDetail, sender: self)
        }
}


// Transfer the data to RecipeDetailsViewController
extension RecipeListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToRecipeDetail {
            guard let detailRecipeVC = segue.destination as? RecipeDetailsViewController else { return }
            detailRecipeVC.selectedHit = self.cellSelected
        }
    }
}



