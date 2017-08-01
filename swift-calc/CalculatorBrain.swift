//
//  CalculatorBrain.swift
//  swift-calc
//
//  Created by Admin on 12.05.17.
//  Copyright © 2017 aparfenov. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private var accumulator = 0.0
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var operations: Dictionary<String, Double> = [
        "π" : M_PI,
        "e" : M_E
    ]
    
    func performOperation(symbol: String) {
        if let constant = operations[symbol] {
            accumulator = constant
        }
        
        /*switch symbol {
        case "π": accumulator = M_PI
        case "√": accumulator = sqrt(accumulator)
        default: break
        }*/
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
