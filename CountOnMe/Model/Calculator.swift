//
//  Calculator.swift
//  CountOnMe
//
//  Created by Anthony Laurent on 24/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol CalculatorDelegate {
    func displayAlert(message: String)
    func didReceiveData(data: String)
}

class Calculator {

    // Properties:
    var delegate: CalculatorDelegate?
    var textView = ""
    var result: Double = 0.00
    var elements: [String] {
        return textView.split(separator: " ").map { "\($0)" }
    }

    // Functions:
    func sendToControler(data: String) {
        delegate?.didReceiveData(data: data)
    }

    private func expressionIsCorrect(elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-"
    }

    private func expressionHaveEnoughElement(elements: [String]) -> Bool {
        return elements.count >= 3
    }

    private func canAddOperator(elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }

    func expressionHaveResult(elements: String) -> Bool {
        return textView.firstIndex(of: "=") != nil
    }

    func tappedAddition() {
        if canAddOperator(elements: elements) {
            textView += " + "
        } else {
            delegate?.displayAlert(message: "operand already exist")
        }
        return sendToControler(data: "+")
    }

    func tappedSubstraction() {
        if canAddOperator(elements: elements) {
            textView += " - "
        } else {
            delegate?.displayAlert(message: "error: operand already exist")
        }
        return sendToControler(data: "-")
    }

    func tappedMultiplication() {
        if canAddOperator(elements: elements) {
            textView += " x "
        } else {
            delegate?.displayAlert(message: "error: operand already exist")
        }
        return sendToControler(data: "x")
    }

    func tappedDivision() {
        if canAddOperator(elements: elements) {
            textView += " ÷ "
        } else {
            delegate?.displayAlert(message: "error: operand already exist")
        }
        return sendToControler(data: "÷")
    }

    func displayAlertInController(message: String) {
        delegate?.displayAlert(message: message)
    }

    func addStringNumber(number: String) {
        if expressionHaveResult(elements: textView) {
            textView = ""
        }
        textView += number
        sendToControler(data: number)
    }

    func tappedEqual() {
        guard expressionIsCorrect(elements: elements) else {
            displayAlertInController(message: "Expression not correct")
            return
        }
        guard expressionHaveEnoughElement(elements: elements) else {
            displayAlertInController(message: "Not enought elements")
            return
        }
        calculate()
    }

    func calculate() {
        var operationsToReduce = elements

        
        while operationsToReduce.count > 1 {
            var priorities = 0
            
            if let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "÷" }) {
                
                priorities = index - 1
            }
            guard let left = Double(operationsToReduce[priorities]) else { return }
            let operand = operationsToReduce[priorities + 1]
            guard let right = Double(operationsToReduce[priorities + 2]) else { return }

            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "÷": result = left / right
            default: fatalError("Unknown operator !")
            }

            for _ in 1...3 {
                operationsToReduce.remove(at: priorities)
            }
            operationsToReduce.insert("\(result)", at: priorities)
        }

        textView += " = \(operationsToReduce.first ?? "Error")"
        sendToControler(data: textView)
    }

    func tappedReset() {
        textView = ""
        return sendToControler(data: textView)
    }
  }

