//
//  ViewController.swift
//  Calculator
//
//  Created by Virtual Machine on 27/05/22.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var calculatorWork: UILabel!
    @IBOutlet weak var calculatorResult: UILabel!
    @IBOutlet weak var bgButtons: UIStackView!
    
    var working: String = ""
    var accounts: [AccountModel] = []
    var itemHistorical: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bgButtons.layer.cornerRadius = 65
        
    }
    
    func getHistorical(item: Int) {
        
        if let item = itemHistorical {
            var itemElement = item
            if itemElement != 0 {
                itemElement = itemElement - 1
                DispatchQueue.main.async {
                    self.calculatorWork.text = self.accounts[itemElement].accountBody
                    self.calculatorResult.text = self.accounts[itemElement].accountResult
                }
            }
        } else {
            print("Error ao identificar historico!!")
            clearAll()
        }
        
    }
    
}

// MARK: - Calculator Numbers
extension CalculatorViewController {
    
    @IBAction func zeroPressed(_ sender: Any) {
        addToWork(value: "0")
    }
    @IBAction func onePressed(_ sender: Any) {
        addToWork(value: "1")
    }
    @IBAction func twoPressed(_ sender: Any) {
        addToWork(value: "2")
    }
    @IBAction func threePressed(_ sender: Any) {
        addToWork(value: "3")
    }
    @IBAction func fourPressed(_ sender: Any) {
        addToWork(value: "4")
    }
    @IBAction func fivePressed(_ sender: Any) {
        addToWork(value: "5")
    }
    @IBAction func sixPressed(_ sender: Any) {
        addToWork(value: "6")
    }
    @IBAction func sevenPressed(_ sender: Any) {
        addToWork(value: "7")
    }
    @IBAction func eightPressed(_ sender: Any) {
        addToWork(value: "8")
    }
    @IBAction func ninePressed(_ sender: Any) {
        addToWork(value: "9")
    }
    
}

// MARK: - Calculator functions
extension CalculatorViewController {
    
    @IBAction func equalsPressed(_ sender: Any) {
        
        if validInput() && working.count >= 3 {
            let result = formatInput()
            let resultString = formatResult(result: result)
            calculatorResult.text = resultString
            accounts.append(AccountModel(accountBody: self.working, accountResult: resultString))
        } else {
            inputError()
        }
        
    }
    
    @IBAction func allClearPressed(_ sender: Any) {
        clearAll()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        clearOne(working: working)
    }
    
    
    @IBAction func percentPressed(_ sender: Any) {
        addToWork(value: "%")
    }
    @IBAction func dividePressed(_ sender: Any) {
        addToWork(value: "/")
    }
    @IBAction func timesPressed(_ sender: Any) {
        addToWork(value: "*")
    }
    @IBAction func minusPressed(_ sender: Any) {
        addToWork(value: "-")
    }
    @IBAction func plusPressed(_ sender: Any) {
        addToWork(value: "+")
    }
    @IBAction func decimalPressed(_ sender: Any) {
        addToWork(value: ".")
    }
    
    func clearAll() {
        working = " "
        calculatorWork.text = " "
        calculatorResult.text = " "
    }
    
    func clearOne(working: String) {
        if working.count >= 1 {
            self.working.removeLast()
            calculatorWork.text = self.working
        }
        
        if working.count <= 1 {
            calculatorWork.text = " "
        }
    }
    
    func addToWork(value: String) {
        if calculatorWork.text != " " {
            working = calculatorWork.text!
            working = working + value
            calculatorWork.text = working
        } else {
            working =  working + value
            calculatorWork.text = working
        }
    }
    
    func formatInput() -> Double {
        let checkWorkForPercent = working.replacingOccurrences(of: "%", with: "*0.01")
        let expression =  NSExpression(format: working)
        return expression.expressionValue(with: nil, context: nil) as! Double
    }
    
    func inputError(){
        let alert = UIAlertController(
            title: "Invalid Input", message: "Calculator unable to do math based on input", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        self.present(alert, animated: true, completion: nil)
        clearAll()
    }
    
    func formatResult(result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }

    }
    
    func validInput() -> Bool {
        var count = 0
        var funcCharIndex = [Int]()
        var previous: Int = -1
        
        for char in working {
            if specialCharacter(char: char) {
                funcCharIndex.append(count)
            }
            count += 1
        }
        
        for index in funcCharIndex {
            if index == 0 {
                return false
            }
            
            if index == working.count - 1 {
                return false
            }
            
            if previous != -1 {
                if index - previous == 1 {
                    return false
                }
            }
            previous = index
        }
        
        return true
    }
    
    func specialCharacter(char: Character) -> Bool {
        
        switch char {
            case "*": return true
            case "%": return true
            case "/": return true
            case "+": return true
            case "-": return true
            case ".": return true
        default:
            return false
        }
    }
    
}

// MARK: - Navigation
extension CalculatorViewController {

    @IBAction func historicPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToHistoric", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHistoric" {
            let result = segue.destination as! HistoricViewController
            result.accounts = accounts
        }
    }

}

