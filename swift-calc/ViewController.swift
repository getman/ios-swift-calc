//
//  ViewController.swift
//  swift-calc
//
//  Created by Admin on 10.05.17.
//  Copyright © 2017 aparfenov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var userIsInTheMiddleOfTyping: Bool = false
    private var userIsInTheMiddleOfTyping2 = false
    
    
    /**display resuls property*/
    @IBOutlet private weak var display: UILabel! = nil
    
    /**computing property. Computed property*/
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            //newValue is a key value
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    /**Performs operations */
    @IBAction private func performOperation(_ sender: UIButton) {
        if (userIsInTheMiddleOfTyping) {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false;
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol == "π" {
//                displayValue = M_PI
                brain.performOperation(symbol: mathematicalSymbol)
            } else if mathematicalSymbol == "√" {
//                displayValue = sqrt(displayValue)
                brain.performOperation(symbol: mathematicalSymbol)
            }
            displayValue = brain.result
        }
    }
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit;
        } else {
            display.text = digit;
        }
        userIsInTheMiddleOfTyping = true;
        print("touch digit \(digit)")
    }
}

