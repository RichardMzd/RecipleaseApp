//
//  MockSessionURL.swift
//  RecipleaseTests
//
//  Created by Richard Arif Mazid on 11/04/2023.
//
import Foundation
import Alamofire
@testable import RecipleaseApp

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

final class MockSessionURL: RecipeProtocol {
    
    // MARK: - Properties
    private let fakeResponse: FakeResponse

    // MARK: - Initializer
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }

    // MARK: - Methods
    func request(url: URL, callBack callback: @escaping (AFDataResponse<Data>) -> Void) {
        let okData = "OK".data(using: .utf8)
        let dataResponse = AFDataResponse<Data>(request: nil, response: fakeResponse.response, data: fakeResponse.data, metrics: nil, serializationDuration: 0, result: .success(okData ?? Data()))
        callback(dataResponse)
    }
}
