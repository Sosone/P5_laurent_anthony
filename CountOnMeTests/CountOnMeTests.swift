//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Anthony Laurent on 24/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
    var calculator: Calculator!
    var controller: ViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        calculator = Calculator()
        controller = ViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        calculator = nil
    }
    func testGivenHaveNoResultWhenTappedAdditionThenResultIsCorrect() {
        calculator.addStringNumber(number: "5")
        calculator.tappedAddition()
        calculator.addStringNumber(number: "3")
        calculator.calculate()
        XCTAssert(calculator.result == 8)
    }
    
    func testGivenHaveNoResultWhenTappedSubstractionThenResultIsCorrect() {
        calculator.addStringNumber(number: "5")
        calculator.tappedSubstraction()
        calculator.addStringNumber(number: "3")
        calculator.tappedEqual()
        XCTAssert(calculator.result == 2)
    }
    
    func testGivenHaveNoResultWhenTappedMultiplicationThenResultIsCorrect() {
        calculator.addStringNumber(number: "5")
        calculator.tappedMultiplication()
        calculator.addStringNumber(number: "3")
        calculator.tappedEqual()
        XCTAssert(calculator.result == 15)
    }
    
    func testGivenHaveNoResultWhenTappedDivisionThenResultIsCorrect() {
        calculator.addStringNumber(number: "51")
        calculator.tappedDivision()
        calculator.addStringNumber(number: "17")
        calculator.tappedEqual()
        XCTAssert(calculator.result == 3)
    }
    
    func testGivenWhenTappedResetThenOperationDisappears() {
        calculator.tappedReset()
        XCTAssert(calculator.textView == "")
        
    }
    
    func testGivenAllOperandWhenVariousOperatorThenPriorityForMultiAndDivide() {
        calculator.addStringNumber(number: "2")
        calculator.tappedAddition()
        calculator.addStringNumber(number: "3")
        calculator.tappedMultiplication()
        calculator.addStringNumber(number: "5")
        calculator.tappedSubstraction()
        calculator.addStringNumber(number: "8")
        calculator.tappedDivision()
        calculator.addStringNumber(number: "4")
        calculator.tappedEqual()
        XCTAssert(calculator.result == 15)
    }
    
    func testGivenExpressionIsNotCorrectWhenTappedEqualThenMessageAppear() {
        calculator.addStringNumber(number: "3")
        calculator.tappedSubstraction()
        calculator.tappedEqual()
        XCTAssertTrue(calculator.textView == "3 - ")
    }
    
    func testGivenExpressionHaveResultWhenTappedEqualThenTextIsNil() {
        calculator.tappedEqual()
        XCTAssertTrue(calculator.textView == "")
    }
    
    func testGivenAddOperatorWhenOperatorIsAlreadySetThenMessageAppear() {
        calculator.addStringNumber(number: "3")
        calculator.tappedAddition()
        calculator.tappedAddition()
        let calculator = Calculator()
        let delegate = FakeCalculatorDelegate()
        calculator.delegate = delegate
        calculator.update(error: "test erreur")
        XCTAssertTrue(delegate.errorCalled)
    }
    
    func testGivenTextViewIsEmptyWhenCalculateThenMessageAppear() {
        calculator.calculate()
        let calculator = Calculator()
        let delegate = FakeCalculatorDelegate()
        calculator.delegate = delegate
        calculator.update(error: "test erreur")
        XCTAssertTrue(delegate.errorCalled)
        }
    
    func testGivenCaculatorWhenErrorThenDelegateCalled() {
        let calculator = Calculator()
        let delegate = FakeCalculatorDelegate()
        calculator.delegate = delegate
        calculator.update(error: "test erreur")
        XCTAssertTrue(delegate.errorCalled)
    }
    
    func testGivenCalculatorWhenNoErrorThenDelegateNotCalled() {
        let calculator = Calculator()
        let delegate = FakeCalculatorDelegate()
        calculator.delegate = delegate
        XCTAssertFalse(delegate.errorCalled)
    }
                
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
class FakeCalculatorDelegate: CalculatorDelegate
{
    var errorCalled = false
    func displayAlert(message: String) {
        errorCalled = true
    }
    
    func didReceiveData(data: String) {
    }
}
