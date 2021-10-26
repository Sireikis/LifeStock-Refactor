//
//  Calculator.swift
//  LifeStock Refactor
//
//  Created by Ignas Sireikis on 10/7/21.
//

import Foundation
import SwiftUI


struct Calculator {
    
    var displayField: String
    
    var subTotal: Int = 0
    var buttonPressed: Bool = false
    var lastOperation: CalculatorButton?
    var lastOperationIsEquals: Bool = false
    
    // !!! TODO Need to fix calculator operations
    mutating func resetCalculatorVariables() {
        subTotal = 0
        buttonPressed = false
        lastOperation = nil
        lastOperationIsEquals = false
    }

    mutating func setCalculatorLifeDisplay(to lifeTotal: Int) {
        displayField = String(lifeTotal)
    }
    
    // Receives button input in LifeChanger and Calculator Views
    mutating func receiveInput(calculatorButton: CalculatorButton) {
        switch calculatorButton {
        case .zero, .one, .two, .three, .four,
             .five, .six, .seven, .eight, .nine:
            if buttonPressed {
                displayField = calculatorButton.title
                buttonPressed = false
            } else {
                if displayField == "0" {
                    displayField = calculatorButton.title
                } else {
                    displayField += calculatorButton.title
                }
            }
        case .plus:
            operatorIdentity(.plus)
        case .minus:
            operatorIdentity(.minus)
        case .multiply:
            operatorIdentity(.multiply)
        case .equals:
            if let currentValue = Int(displayField) {
                switch lastOperation {
                case .plus:
                    displayField = String(subTotal + currentValue)
                case .minus:
                    if lastOperationIsEquals {
                        displayField = String(currentValue - subTotal)
                    } else {
                        displayField = String(subTotal - currentValue)
                    }
                case .multiply:
                    displayField = String(subTotal * currentValue)
                default: return
                }
                if buttonPressed == false {
                    subTotal = currentValue
                    buttonPressed = true
                }
                lastOperationIsEquals = true
            }
        case .delete:
            if displayField.isEmpty == false {
                displayField.removeLast()
            }
        case .ac:
            displayField = "0"
            subTotal = 0
            buttonPressed = false
            lastOperation = nil
            lastOperationIsEquals = false
        default: return
        }
    }
    
    mutating func operatorIdentity(_ lastOperator: CalculatorButton) {
        if buttonPressed == false {
            if let currentValue = Int(displayField) {
                switch lastOperation {
                case .plus:
                    subTotal += currentValue
                    displayField = String(subTotal)
                case .minus:
                    subTotal -= currentValue
                    displayField = String(subTotal)
                case .multiply:
                    subTotal *= currentValue
                    displayField = String(subTotal)
                default:
                    subTotal = currentValue
                }
                lastOperation = lastOperator
                buttonPressed = true
            }
        }
        if lastOperationIsEquals {
            if let currentValue = Int(displayField) {
                subTotal = currentValue
                displayField = String(subTotal)
            }
            lastOperation = lastOperator
            lastOperationIsEquals = false
            buttonPressed = true
        }
    }
}


enum CalculatorButton {
    
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply
    case spacer, delete
    case ac
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
            
        case .equals: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
            
        case .spacer: return ""
        case .delete: return "⌫"
            
        case .ac: return "AC"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four,
             .five, .six, .seven, .eight, .nine:
            return Color(.darkGray)
        
        case .equals, .plus, .minus, .multiply:
            return Color(.orange)
        case .spacer, .delete:
            return LifeStockColor.darkBackground
        case .ac:
            return Color(.clear)
        }
    }
}
