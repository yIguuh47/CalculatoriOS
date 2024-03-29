//
//  HistoricViewController.swift
//  Calculator
//
//  Created by Virtual Machine on 01/06/22.
//

import UIKit

protocol SetDataHistorical {
    func setDataHistorical(accounts: [AccountModel], item: Int)
}

class HistoricViewController: UIViewController {

    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var accountView: UITableView!
    var delegateSetData: SetDataHistorical?
    var accounts: [AccountModel] = []
    var item = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        accountView.delegate = self
        accountView.dataSource = self
    }
    

}

// MARK: - TableView
extension HistoricViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if accounts.count <= 0 {
            errorLbl.text = "There is no history yet"
        } else {
            errorLbl.text = " "
        }
        
        return accounts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = accountView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        let account = accounts[indexPath.row]
        cell.accountBodyLbl.text = account.accountBody
        cell.resultAccountLbl.text = account.accountResult
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomCell else { return }
        
        item = indexPath.row + 1
        performSegue(withIdentifier: "goToReturn", sender: self)
    }
    
}


// MARK: - Navigation
extension HistoricViewController {

    @IBAction func BackPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToReturn", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToReturn" {
            let result = segue.destination as! CalculatorViewController
            result.itemHistorical = item
            result.accounts = accounts
            result.getHistorical(item: item)
        }
    }

}
