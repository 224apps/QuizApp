//
//  QuestionViewContorllerTest.swift
//  QuizAppTests
//
//  Created by Abdoulaye Diallo on 1/15/21.
//

import Foundation
import XCTest

@testable import QuizApp
class QuestionViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renders_QuestionHeaderText(){
        let sut = QuestionViewController(question: "Q1", options: [])
        _ = sut.view
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withNoOptions_rendersZeroOptions(){
        let sut = QuestionViewController(question: "Q1", options: [])
        
        _ = sut.view
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0 ), 0)
    }
    
    func test_viewDidLoad_withOneOption_rendersZeroOptions(){
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        
        _ = sut.view
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0 ), 1)
    }
    
    func test_viewDidLoad_withOneOption_rendersOneOptionText(){
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        
        _ = sut.view
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertEqual(cell?.textLabel?.text, "A1")
    }
}