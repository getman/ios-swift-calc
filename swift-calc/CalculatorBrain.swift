//
//  CalculatorBrain.swift
//  swift-calc
//
//  Created by Admin on 12.05.17.
//  Copyright © 2017 aparfenov. All rights reserved.
//

import Foundation

/*func multiply(op1: Double, op2: Double) -> Double{
    return op1 * op2
}*/

/**1st variant - this function called by refference*/
func divide(op1: Double, op2: Double) -> Double {
    return op1 / op2
}

class CalculatorBrain {
    private var accumulator = 0.0
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI), //M_PI,
        "e" : Operation.Constant(M_E), //M_E,
        "√" : Operation.UnaryOperation(sqrt), //sqrt
        "cos" : Operation.UnaryOperation(cos), //cos
        /**2nd variant - closure with the full syntax*/
        "×" : Operation.BinaryOperation({ (op1: Double, op2: Double) -> Double in
                return op1 * op2
            }),
        /**3rd variant - closure with the type inferrence for Double*/
        "−" : Operation.BinaryOperation({ (op1, op2) in return op1 - op2}),
        /**4th variant - closure with default arguments	and without in parameters*/
        "+" : Operation.BinaryOperation({return $0 + $1}),
        "÷" : Operation.BinaryOperation(divide),
        "=" : Operation.Equals
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    private var pending: PendingBinaryOperation?
    
    private func executePendingBinaryOperation() {
        if (pending != nil) {
            accumulator = pending!.binaryFunctionRef(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private struct PendingBinaryOperation {
        var binaryFunctionRef: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let associatedValue): accumulator = associatedValue
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperation(binaryFunctionRef: function, firstOperand: accumulator)
            case .Equals: executePendingBinaryOperation()
            }
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
