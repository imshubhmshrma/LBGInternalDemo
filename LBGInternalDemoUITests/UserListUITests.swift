//
//  UserListUITests.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 30/12/25.
//

import XCTest

final class UserListUITests: XCTestCase{
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
    }
    
    
    func test_nav_bar_is_visible(){
        let title = app.navigationBars["Users"]
        XCTAssertTrue(title.exists)
    }
    
    
    func test_userlistcell_has_atleast_one_cell(){
        let cells = app.collectionViews["userListView"]
        let didShows = cells.waitForExistence(timeout: 2)
         XCTAssertTrue(didShows)
        
    }
    
    func test_users_firstCell_is_showing(){
        //arrange
        let firstCell = app.buttons["user_cell_1"]
        
        //act
       _ = firstCell.waitForExistence(timeout: 2)
        
        //assert
        XCTAssertEqual(firstCell.exists, true)
    }
    
    func test_userlist_first_cell_content_firstName_only(){
       //arrange
        let firstCell = app.staticTexts["userCellView_txt_firstName_1"]
        //act
       _ = firstCell.waitForExistence(timeout: 2)
        //assert
        XCTAssertEqual(firstCell.label,"Emily")
    }
}



final class DoingItAgain: XCTestCase{
    
    let app: XCUIApplication = XCUIApplication()
    
    
    override func setUp() {
        super.setUp()
       continueAfterFailure = false
        app.launch()
    }
    
    
    func test_check_nav_bar(){
        let navbar = app.navigationBars["Users"]
        _ = navbar.waitForExistence(timeout: 2)
        XCTAssertTrue(navbar.exists)
        
    }
    
    
    func test_user_tapped_on_cell_two(){
        let list = app.collectionViews["userListView"]
        XCTAssertTrue(list.exists, "List loads up")
        
        let secondCell = list.buttons["user_cell_2"]
        XCTAssertTrue(
                secondCell.waitForExistence(timeout: 2),
                "Second user cell should exist"
            )
        secondCell.tap()
        let detailPageNavBar = app.navigationBars["User Details"]
        _ = secondCell.waitForExistence(timeout: 2)
        XCTAssertTrue(detailPageNavBar.exists, "Navigation bar is showing for details screen") 
    }
}
