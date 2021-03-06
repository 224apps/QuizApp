//
//  QuestionViewContorllerTest.swift
//  QuizAppTests
//
//  Created by Abdoulaye Diallo on 1/15/21.
//

import Foundation
import XCTest
import UIKit

@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renders_QuestionHeaderText(){
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }

    func test_viewDidLoad_rendersOptions(){
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0 ), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0 ), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0 ), 2)
    }
    
    func test_viewDidLoad_rendersOptionsText(){
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
    }
    
    func test_optionSelected_withSingleSelection_notifiesDelegateWhenLastSelection(){
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1","A2"]){ receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionDeselected_withSingleSelection_doesNotNotifyDelegateWithEmptySelection(){
        var callbackCount = 0
        let sut = makeSUT(options: ["A1","A2"]){ _ in callbackCount += 1 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_optionSelected_withMultipleSelectionEnabled_notifiesDelegateSelection(){
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1","A2"]){ receivedAnswer = $0 }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
    }
    
    func test_optionDeselected_withMultipleSelectionEnabled_notifiesDelegate(){
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1","A2"]){ receivedAnswer = $0 }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer, [])
    }
    
    //MARk: - Helpers
    func makeSUT(question: String = "",
                 options: [String] = [],
                 selection: @escaping ([String])-> Void = {_ in } ) -> QuestionViewController {
        let sut = QuestionViewController(question: question,
                                         options: options,
                                         selection: selection)
        _ = sut.view
        return sut
    }
}


//MARK: - UITableView extension

private extension UITableView {
    
    func cell(at row: Int) -> UITableViewCell? {
        return  dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
    
    func select(row: Int){
        let indexpath = IndexPath(row: row, section: 0)
        selectRow(at: indexpath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: indexpath)
    }
    
    func deselect(row: Int){
        let indexpath = IndexPath(row: row, section: 0)
        deselectRow(at: indexpath, animated: false)
        delegate?.tableView?(self, didDeselectRowAt: indexpath)
    }
}
