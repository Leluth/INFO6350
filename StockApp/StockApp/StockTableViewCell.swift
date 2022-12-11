//
//  StockTableViewCell.swift
//  StockApp
//
//  Created by Shaoshuai Xu on 12/10/22.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
