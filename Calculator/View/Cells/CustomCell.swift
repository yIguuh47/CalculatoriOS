//
//  CustomCell.swift
//  Calculator
//
//  Created by Virtual Machine on 03/06/22.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var accountBodyLbl: UILabel!
    @IBOutlet weak var resultAccountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
