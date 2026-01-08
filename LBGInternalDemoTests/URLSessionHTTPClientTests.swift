//
//  URLSessionHTTPClientTests.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 29/12/25.
//

import XCTest
@testable import LBGInternalDemo

final class URLSessionHTTPClientTests: XCTestCase{
    
    private var client : NetworkClient!
    private var session: URLSession!
    private let apiURL = URL(string:"https://dummyjson.com/users")
    let validJSONData = """
        {
        "users": [
          {
            "id": 1,
            "firstName": "Shubham",
            "lastName": "Johnson"
          },
        ]
        }
        """.data(using: .utf8)!
    
    let inValidJSONData = """
        {
        "users": [
          {
            "idd": 1,
            "firstName": "Shubham",
            "lastName": "Johnson"
          },
        ]
        }
        """.data(using: .utf8)!
    
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        client = NetworkClient(session: session)
    }
    
    
    @MainActor func test_success_200(){
         //Arrange
        let response = HTTPURLResponse(url: apiURL!, statusCode: 200, httpVersion: nil, headerFields: nil    )
        let expectation = expectation(description: "checking success case with 200 status code")
        MockURLProtocol.mockResponse = response
        MockURLProtocol.mockData = validJSONData
        
        
        //ACT
        client.makeGetReques(url: apiURL!) { (result: Result<UsersResponse,APIError>) in
            switch result{
            case .success(let response):
                //ASSERT
               // XCTAssertNotNil(response)
                XCTAssertEqual(response.users.count, 1)
                XCTAssertEqual(response.users.first?.id, 1)
                XCTAssertEqual(response.users.first?.firstName, "Shubham")
            case .failure(let error):
                XCTFail("falied this test \(error)")
                
                
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout:5)
    }
    
    @MainActor func test_failure_inalidJSONKeys(){
        let response = HTTPURLResponse(url: apiURL!, statusCode: 300, httpVersion: nil, headerFields: nil)
        let expectation = expectation(description: "test_failure_inalidJSONKeys")
        
        MockURLProtocol.mockResponse = response
        MockURLProtocol.mockData = inValidJSONData
        
        
        client.makeGetReques(url: apiURL!) { (result: Result<UsersResponse,APIError> ) in
            switch result{
            case .success:
                XCTFail("this test should have failed")
            case .failure(let error):
                XCTAssertEqual(error,APIError.invalidResponse)
                      
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    
    @MainActor func test_success_202(){
         //Arrange
        let response = HTTPURLResponse(url: apiURL!, statusCode: 200, httpVersion: nil, headerFields: nil    )
        let expectation = expectation(description: "checking success case with 200 status code")
        MockURLProtocol.mockResponse = response
        MockURLProtocol.mockData = validJSONData
        
        
        //ACT
        client.makeGetReques(url: apiURL!) { (result: Result<UsersResponse,APIError>) in
            switch result{
            case .success(let response):
                //ASSERT
               // XCTAssertNotNil(response)
                XCTAssertEqual(response.users.count, 1)
                XCTAssertEqual(response.users.first?.id, 1)
                XCTAssertEqual(response.users.first?.firstName, "Shubham")
            case .failure(let error):
                XCTFail("falied this test \(error)")
                
                
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout:5)
    }
    
}
