//
//  MockNetworkLayerTest.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 26/12/25.
//

import XCTest
@testable import LBGInternalDemo

final class MockNetworkLayerTest: XCTestCase {
    
    
    func test_Success_Scanerio(){
        //arrange
        
        let expectation = expectation(description: "testing the Success_Scanerio")
        //act
        NetworkLayer.shared.makeGetRequest(urlString: "https://dummyjson.com/users") { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                expectation.fulfill()
            case .failure(_):
                XCTFail("failed error")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 6)
    }
    
    func test_Failure_Scanerio_Invalid_URL(){
        //arrange
        
        let expectation = expectation(description: "testing the Success_Scanerio")
        //act
        NetworkLayer.shared.makeGetRequest(urlString: "$$") { result in
            switch result {
            case .success(_):
                XCTFail("Success should not be returned for invalid URL")
            case .failure(let error):
                XCTAssertEqual(error, .invalidData)
                switch error{
                case.decodingError:
                    print("decodingError")
                case .invalidURL:
                    print("invalidURL")
                case .invalidResponse:
                    print("invalidResponse")
                case .invalidData:
                    print("invalidData")
                }
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 6)
    }
    
    
    @MainActor
    func test_Network_Client() {
        let session = URLSession.shared
        let client = NetworkClient(session: session)
        let expectation = expectation(description: "lasan")
        guard let urll = URL(string: "https://dummyjson.com/users") else { return  }
        client.makeGetReques(url: urll) { result in
            let result: Result<UsersResponse, APIError> = result
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error, .invalidData)
                switch error{
                case.decodingError:
                    print("decodingError")
                case .invalidURL:
                    print("invalidURL")
                case .invalidResponse:
                    print("invalidResponse")
                case .invalidData:
                    print("invalidData")
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 6)
    }
}
