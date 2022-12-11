//
//  DetailsViewController.swift
//  StockApp
//
//  Created by Shaoshuai Xu on 12/10/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailsViewController: UIViewController {

    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    var symbol = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStock()
    }
    
    func getStock() {
        let url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/getstock?symbol=" + self.symbol
        print(url)
        AF.request(url).responseJSON { responseData in
            if responseData.error != nil {
                print(responseData.error!)
                return
            }
            
            let stockData = JSON(responseData.data as Any)
            print(stockData)
            let company = stockData["CompanyName"].stringValue
            let price = stockData["Price"].stringValue
            
            
            self.lblCompany.text = company
            self.lblSymbol.text = self.symbol
            self.lblPrice.text = price
        }
    }

}
