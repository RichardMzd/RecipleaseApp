//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 27/09/2022.
//

import Foundation
import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
//  MARK: - Outlets
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var listTableview: UITableView!
    
//  MARK: - Propreties
    private var ingredientsList: [String] = []
    private var recipesArray: [Hit]?
    private let service: RecipeService = RecipeService()
    private let segueToRecipesList = "Search_List"
    
//  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navItemSettings()
        view.backgroundColor = .darkGray
        listTableview.reloadData()
        listTableview.delegate = self
        listTableview.dataSource = self
        setupAccessibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listTableview.reloadData()
    }
    
//  MARK: - Actions
    
    @IBAction func addIngredients() {
        if let text = searchTextField.text, !text.isEmpty {
            addIngredient(text)
            searchTextField.text = ""
        }
        listTableview.reloadData()
        searchTextField.resignFirstResponder()
    }
    
    @IBAction func clearList() {
        ingredientsList.removeAll()
        listTableview.reloadData()
    }
    
    @IBAction func searchRecipe() {
        if listTableview.numberOfRows(inSection: 0) < 1 {
            let alert = UIAlertController(title: "No ingredient", message: "Add an ingredient !", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            getRecipes()
        }
    }

//  MARK: - Methods
    private  func addIngredient(_ ingredient : String){
        ingredientsList.append(ingredient)
        self.listTableview.reloadData()
    }
    
    private func getRecipes() {
        // network call
        service.getRecipe(ingredients: ingredientsList) { (result) in
            switch result {
            case .success(let recipeInfo):
                self.recipesArray = recipeInfo?.hits
                self.performSegue(withIdentifier: self.segueToRecipesList, sender: self)
            case .failure(let error) :
                self.statusError(status: error, result: result)
                self.searchButton.isEnabled = true
            }
        }
    }
    
    // Method which handle API error message alerts
    func statusError(status: ErrorAPI, result: Result<AllRecipes?, ErrorAPI>) {
        switch result {
        case .success(let weather):
            if weather != nil {
                // Handle success case
            }
        case .failure(let error):
            self.alertServerAccess(error: error.description)
        }
    }
    
    func navItemSettings() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 20) ?? (Any).self, NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupAccessibility() {
        VoiceOver.shared.voiceOver(object: searchTextField, hint: "Enter your ingredient")
        VoiceOver.shared.voiceOver(object: listTableview, hint: "List of ingredients")
        VoiceOver.shared.voiceOver(object: addButton, hint: "Add")
        VoiceOver.shared.voiceOver(object: clearButton, hint: "Delete")
        VoiceOver.shared.voiceOver(object: searchButton, hint: "Search")
    }
}

// Transfer data to RecipeListViewController
extension SearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToRecipesList {
            guard let listRecipesVC = segue.destination as? RecipeListViewController else { return }
            listRecipesVC.recipesArray = recipesArray
        }
    }
}


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? IngredientsTableViewCell
        else {
            return UITableViewCell()
        }
        let ingredient = ingredientsList[indexPath.row]
        cell.setupCell(withIngredient: ingredient)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredientsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

class IngredientsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(withIngredient ingredient: String) {
        ingredientLabel?.text = "- " + ingredient.localizedCapitalized
    }
}

