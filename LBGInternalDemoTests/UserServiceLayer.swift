//
//  UserServiceLayer.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 26/12/25.
//

import XCTest
@testable import LBGInternalDemo


final class TestServiceLayer : XCTestCase {
    
    func test_checkUsersLoading(){
        //arrange
        let serviuce = UserService()
        let expectation = expectation(description: "checking the service layer")
        
        //act
        serviuce.getUsers { result in
            switch result{
            case .success(let users):
                print("success")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    //assert
                    XCTAssertEqual(users.count > 0, true)
                    expectation.fulfill()
                }
            case .failure(let error):
                print("error: \(error)")
                XCTFail("failed test")
            }
        }
         
        waitForExpectations(timeout: 5)
    }
     
    @MainActor func test_checkUser() {
        let serviuce = UserService()
        let expectation = expectation(description: "checking the service layer")
        
        serviuce.getUsersWithoutPublisher { result in
            switch result{
            case.success(let user):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    XCTAssertEqual(user.count > 0, true)
                }
            case .failure(let error):
                print("error: \(error)")
                XCTFail("failed test")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 6)
    }
    
    func test_Service_layer() {
        let service = UserService()
        let expectation = expectation(description: "checking the service layer")
        
        service.getUsersFromNetworkLayer { result in
            switch result{
            case .success(let user):
                XCTAssertEqual(user.count > 0, true)
                expectation.fulfill()
                
            case .failure(_):
                XCTFail("failed")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5)
    }
 }
