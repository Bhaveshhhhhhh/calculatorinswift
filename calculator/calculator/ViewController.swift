//
//  ViewController.swift
//  calculator
//
//  Created by Student on 25/01/23.
//  Copyright © 2023 ARK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculatorWorking: UILabel!
    @IBOutlet weak var calculatorResults: UILabel!
    
    var working:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clearAll()
    }
    
    func clearAll(){
        working = ""
        calculatorResults.text = ""
        calculatorWorking.text = ""
    }
    
    func addToWorkings(value: String)
    {
        working = working + value
        calculatorWorking.text = working
    }

    @IBAction func equal(_ sender: Any) {
        if(validInput())
        {
            let checkedWorkingsForPercent = working.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: checkedWorkingsForPercent)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            calculatorResults.text = resultString
        }
        else
        {
            let alert = UIAlertController(
                title: "Invalid Input",
                message: "Calculator unable to do math based on input",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func validInput() ->Bool
    {
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in working
        {
            if(specialCharacter(char: char))
            {
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        var previous: Int = -1
        
        for index in funcCharIndexes
        {
            if(index == 0)
            {
                return false
            }
            
            if(index == working.count - 1)
            {
                return false
            }
            
            if (previous != -1)
            {
                if(index - previous == 1)
                {
                    return false
                }
            }
            previous = index
        }
        
        return true
    }
    func specialCharacter (char: Character) -> Bool
    {
        if(char == "*")
        {
            return true
        }
        if(char == "/")
        {
            return true
        }
        if(char == "+")
        {
            return true
        }
        return false
    }
    
    func formatResult(result: Double) -> String
    {
        if(result.truncatingRemainder(dividingBy: 1) == 0)
        {
            return String(format: "%.0f", result)
        }
        else
        {
            return String(format: "%.2f", result)
        }
    }
    @IBAction func zero(_ sender: Any) {
        addToWorkings(value: "0")
    }
    @IBAction func dot(_ sender: Any) {
        addToWorkings(value: ".")
    }
    @IBAction func add(_ sender: Any) {
        addToWorkings(value: "+")
    }
    @IBAction func three(_ sender: Any) {
        addToWorkings(value: "3")
    }
    @IBAction func two(_ sender: Any) {
        addToWorkings(value: "2")
    }
    @IBAction func one(_ sender: Any) {
        addToWorkings(value: "1")
    }
    @IBAction func sub(_ sender: Any) {
        addToWorkings(value: "-")
    }
    @IBAction func six(_ sender: Any) {
        addToWorkings(value: "6")
    }
    @IBAction func five(_ sender: Any) {
        addToWorkings(value: "5")
    }
    @IBAction func four(_ sender: Any) {
        addToWorkings(value: "4")
    }
    @IBAction func multi(_ sender: Any) {
        addToWorkings(value: "*")
    }
    @IBAction func nine(_ sender: Any) {
        addToWorkings(value: "9")
    }
    @IBAction func eight(_ sender: Any) {
        addToWorkings(value: "8")
    }
    @IBAction func seven(_ sender: Any) {
        addToWorkings(value: "7")
    }
    @IBAction func divTap(_ sender: Any) {
        addToWorkings(value: "/")
    }
    @IBAction func perTap(_ sender: Any) {
        addToWorkings(value: "%")
    }
    @IBAction func clearTap(_ sender: Any) {
        if(!working.isEmpty)
        {
            working.removeLast()
            calculatorWorking.text = working
        }
    }
    
    @IBAction func deleteTap(_ sender: Any) {
        clearAll()
    }
}

