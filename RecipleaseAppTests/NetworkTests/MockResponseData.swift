//
//  MockResponseData.swift
//  RecipleaseTests
//
//  Created by Richard Arif Mazid on 12/04/2023.
//
import Foundation

class MockResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class ModelError: Error {}
    static let RecipesError = ModelError()
    
    static var recipeCorrectData: Data {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "Recipes", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let recipeIncorrectData = "erreur".data(using: .utf8)!
    
    static let responseEmpty = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseError = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
    
    static let invalidData = "invalidData".data(using: .utf8)!
}
