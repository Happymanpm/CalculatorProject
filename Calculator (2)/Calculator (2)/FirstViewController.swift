//
//  FirstViewController.swift
//  Calculator (2)
//
//  Created by Lachlan on 19/4/17.
//
//

import UIKit
import QuartzCore
import Darwin


class FirstViewController: AnswerFieldsViewController {
    //MARK: Variable Declarations
    var calcNumber1: Double = 0;
    var calcNumber2: Double = 0;
    var answer: Double = 0;
    var operStage = 1;
    var isDecimal = false;
    var decimalPlace: Int = 1;
    var calcOperator = "";
    
    //MARK: Button and Label Actions
    @IBOutlet weak var answerLabel: UITextField!
    @IBOutlet weak var subAnswerLabel: UITextField!
    
    // Detect button press from certain button
    @IBAction func numberPressed(_ sender: UIButton) {
        if (operStage == 3) {
            resetStuff(type: "quickClear")
        }
        // Get contents of button
        guard let senderTitle = sender.currentTitle else {
            return;
        }
        
        if let number = Double(senderTitle) {
            // Button pressed is a number
            if (operStage == 1) {
                if (isDecimal == false) {
                    calcNumber1 *= 10
                    calcNumber1 += number
                } else {
                    calcNumber1 += number / pow(10.0, Double(decimalPlace))
                    decimalPlace += 1
                }
                
            } else if (operStage == 2) {
                if (isDecimal == false) {
                    calcNumber2 *= 10
                    calcNumber2 += number
                } else {
                    calcNumber2 += number / pow(10.0, Double(decimalPlace))
                    decimalPlace += 1
                }
            }
            appendToAnswerLabels(value: senderTitle)
        } else {
            // Button pressed is not a number (.)
            if(isDecimal == false) {
                isDecimal = true
                appendToAnswerLabels(value: senderTitle)
            }
        }

    }
    
    func appendToAnswerLabels(value: String) {
        
        // Add number to label at top
        answerLabel.text! += value
        subAnswerLabel.text! += value
    }
    
    // Detect and store operator used
    @IBAction func operatorPressed(_ sender: UIButton) {
        if (operStage == 1) {
            //equals(UIButton())
            calcOperator = sender.currentTitle!
            subAnswerLabel.text! += (" " + calcOperator + " ")
            resetStuff(type: "stageTwo")
        } else if (operStage == 3 || operStage == 2) {
            if (operStage == 2 && calcNumber2 != 0) {
                self.equals(nil)
            }
            calcNumber1 = answer
            calcNumber2 = 0
            calcOperator = sender.currentTitle!
            subAnswerLabel.text! += (" " + calcOperator + " ")
            resetStuff(type: "stageTwo")
            printInfo()
        }
        
    }
    
    // The Equals (=) Button!
    @IBAction func equals(_ sender: UIButton?) {
        subAnswerLabel.text! += (" = ")
        guard calcOperator != "÷" || calcNumber2 != 0 else {
            answerLabel.text = "Error (÷ by 0)"
            subAnswerLabel.text! += "Error"
            resetStuff(type: "answerDisplayed")
            return;
        }
        
        switch(calcOperator) {
        case "+":
            answer = calcNumber1 + calcNumber2
        case "-":
            answer = calcNumber1 - calcNumber2
        case "x":
            answer = calcNumber1 * calcNumber2
        case "÷":
            answer = calcNumber1 / calcNumber2
        default:
            answer = calcNumber1
        }
        
        answerLabel.text = String(answer)
        subAnswerLabel.text! += String(answer)
        resetStuff(type: "answerDisplayed")
    }
    
    
    // The Clear Button
    @IBAction func clear(_ sender: UIButton) {
        resetStuff(type: "fullClear")
    }
    
    //MARK: Reset Stuff
    
    // Resets Certain Elements
    func resetStuff(type: String) {
        isDecimal = false
        decimalPlace = 1
        switch(type) {
        case "fullClear":
            printInfo()
            calcNumber1 = 0; calcNumber2 = 0;
            answerLabel.text = "";
            operStage = 1;
            calcOperator = "";
            subAnswerLabel.text = "";
        case "answerDisplayed":
            operStage = 3;
        case "stageTwo":
            answerLabel.text = "";
            operStage = 2;
        case "quickClear":
            printInfo()
            calcNumber1 = 0; calcNumber2 = 0;
            answerLabel.text = "";
            operStage = 1;
            calcOperator = "";
            subAnswerLabel.text = "";
        default:
            print("Error - Default Switch Case")
        }
    }
    
    func printInfo() {
        print("Calculation Number 1: \(calcNumber1)");
        print("Calculation Number 2: \(calcNumber2)");
        print("Operator Used: \(calcOperator)");
        print("Answer: \(answer)");
        print("------------------------");
    }

    
    //MARK: Other Stuff
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.'
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

