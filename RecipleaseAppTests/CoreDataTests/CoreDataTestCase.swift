//
//  CoreDataTestCase.swift
//  RecipleaseAppTests
//
//  Created by Richard Arif Mazid on 13/04/2023.
//

import XCTest
@testable import RecipleaseApp

final class CoreDataTestCase: XCTestCase {

    // MARK: - Properties
       var coreDataStack: MockCoreDataStack!
       var coreDataManager: DataManager!

       //MARK: - Tests Life Cycle
       override func setUp() {
           super.setUp()
           coreDataStack = MockCoreDataStack()
           coreDataManager = DataManager(coreDataStack: coreDataStack)
       }

       override func tearDown() {
           super.tearDown()
           coreDataManager = nil
           coreDataStack = nil
       }

       // MARK: - Tests
    
       func testAddTeskMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
           coreDataManager.saveRecipe(label: "Lemon", image: "", yield: 3, totalTime: 15, ingredientsLines: [""], url: "")
           XCTAssertTrue(!coreDataManager.favoritesRecipes.isEmpty)
           XCTAssertTrue(coreDataManager.favoritesRecipes.count == 1)
           XCTAssertTrue(coreDataManager.favoritesRecipes[0].label == "Lemon")
       }

       func testDeleteAllTasksMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
           coreDataManager.saveRecipe(label: "Lemon", image: "", yield: 3, totalTime: 15, ingredientsLines: [""], url: "")
           coreDataManager.deleteRecipe(label: "Lemon")
           XCTAssertTrue(coreDataManager.favoritesRecipes.isEmpty)
       }
       
    func testRecipeIsExist() {
           coreDataManager.saveRecipe(label: "Lemon", image: "", yield: 3, totalTime: 15, ingredientsLines: [""], url: "")
           let recipeAlreadySaved = coreDataManager.recipeAlreadySaved(label: "Lemon")
           XCTAssertTrue(recipeAlreadySaved)
           XCTAssertTrue(coreDataManager.favoritesRecipes.count == 1)
       }


}
