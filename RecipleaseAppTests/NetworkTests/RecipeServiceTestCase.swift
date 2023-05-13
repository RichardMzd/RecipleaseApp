//
//  RecipeServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Richard Arif Mazid on 12/04/2023.
//
import XCTest
@testable import RecipleaseApp

final class RecipeServiceTestCase: XCTestCase {
    
    func testGetData_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = MockSessionURL(fakeResponse: FakeResponse(response: nil, data: nil))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipe(ingredients: ["salt"], callback: { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with no data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = MockSessionURL(fakeResponse: FakeResponse(response: MockResponseData.responseKO, data: MockResponseData.recipeIncorrectData))
        let edamamService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        edamamService.getRecipe(ingredients: ["salt"], callback: { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with incorrect response failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = MockSessionURL(fakeResponse: FakeResponse(response: MockResponseData.responseOK, data: MockResponseData.recipeIncorrectData))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipe(ingredients: ["Salt"], callback: { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with undecodable data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetData_WhenEmptyResponseIsPassed_ThenShouldReturnFailedCallback() {
            let session = MockSessionURL(fakeResponse: FakeResponse(response: MockResponseData.responseEmpty, data: nil))
            let requestService = RecipeService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            
            requestService.getRecipe(ingredients: ["salt"]) { result in
                guard case .failure(let error) = result else {
                    XCTFail("Test getData method with empty response failed.")
                    return
                }
                
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 0.01)
        }
    
    func testGetData_WhenErrorResponseIsPassed_ThenShouldReturnFailedCallback() {
            let session = MockSessionURL(fakeResponse: FakeResponse(response: MockResponseData.responseError, data: nil))
            let requestService = RecipeService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            
            requestService.getRecipe(ingredients: ["salt"]) { result in
                guard case .failure(let error) = result else {
                    XCTFail("Test getData method with error response failed.")
                    return
                }
                
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 0.01)
        }
    
    func testGetData_WhenInvalidDataIsPassed_ThenShouldReturnFailedCallback() {
            let session = MockSessionURL(fakeResponse: FakeResponse(response: MockResponseData.responseOK, data: MockResponseData.invalidData))
            let requestService = RecipeService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            
            requestService.getRecipe(ingredients: ["Salt"]) { result in
                guard case .failure(let error) = result else {
                    XCTFail("Test getData method with invalid data failed.")
                    return
                }
                
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 0.01)
        }
    
    func testGetData_WhenDelayedCallback_ThenShouldReturnSucceededCallback() {
          let session = MockSessionURL(fakeResponse: FakeResponse(response: MockResponseData.responseOK, data: MockResponseData.recipeCorrectData))
          let requestService = RecipeService(session: session)
          let expectation = XCTestExpectation(description: "Wait for queue change.")
          expectation.expectedFulfillmentCount = 2
          
          requestService.getRecipe(ingredients: ["salt"]) { result in
              guard case .success(let data) = result else {
                  XCTFail("Test getData method with delayed callback failed.")
                  return
              }
              
              XCTAssertNotNil(data)
              expectation.fulfill()
          }
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              expectation.fulfill()
          }
          
          wait(for: [expectation], timeout: 2)
      }
}
