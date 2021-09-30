//
//  Calculator.swift
//  CountOnMe
//
//  Created by Anthony Laurent on 24/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol CalculatorDelegate: AnyObject {
    func displayAlert(message: String)
    func didReceiveData(data: String)
}

class Calculator {

    // Properties:
    weak var delegate: CalculatorDelegate?
    var textView = ""
    var result: Double = 0.00
    var elements: [String] {
        return textView.split(separator: " ").map { "\($0)" }
    }

    // Functions:
    func update(data: String) {
        delegate?.didReceiveData(data: data)
    }

    private func expressionIsCorrect(elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }

    private func expressionHaveEnoughElement(elements: [String]) -> Bool {
        return elements.count >= 3
    }

    private func canAddOperator(elements: [String]) -> Bool {
        return expressionIsCorrect(elements: elements)
    }

    func expressionHaveResult(elements: String) -> Bool {
        return textView.firstIndex(of: "=") != nil
    }

    func tappedAddition() {
        addOperator(text: "+")
    }

    func tappedSubstraction() {
        addOperator(text: "-")
    }

    func tappedMultiplication() {
        addOperator(text: "x")
    }

    func tappedDivision() {
        addOperator(text: "÷")
    }
    
    private func addOperator(text: String) {
        if canAddOperator(elements: elements) {
            textView += " \(text) "
        } else {
            delegate?.displayAlert(message: "error: operand already exist")
        }
        update(data: "\(text)")
    }

    func update(error: String) {
        delegate?.displayAlert(message: error)
    }

    func addStringNumber(number: String) {
        if expressionHaveResult(elements: textView) {
            textView = ""
        }
        textView += number
        update(data: number)
    }

    func tappedEqual() {
        guard expressionIsCorrect(elements: elements) else {
            update(error: "Expression not correct")
            return
        }
        guard expressionHaveEnoughElement(elements: elements) else {
            update(error: "Not enought elements")
            return
        }
        calculate()
    }
    
    func tappedReset() {
        textView = ""
        return update(data: textView)
    }

    func calculate() {
        var operationsToReduce = elements
        
        while operationsToReduce.count > 1 {
            var place = 0
            
            if let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "÷" }) {
                
                place = index - 1
            }
            guard let left = Double(operationsToReduce[place]) else { return }
            let operand = operationsToReduce[place + 1]
            guard let right = Double(operationsToReduce[place + 2]) else { return }

            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "÷": result = left / right
            default: update(error: "Unknown operator !")
                tappedReset()
            }

            for _ in 1...3 {
                operationsToReduce.remove(at: place)
            }
            operationsToReduce.insert("\(result)", at: place)
        }

        textView += " = \(operationsToReduce.first ?? "Error")"
        update(data: textView)
    }
  }

