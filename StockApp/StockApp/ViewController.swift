//
//  ViewController.swift
//  StockApp
//
//  Created by Shaoshuai Xu on 12/10/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    var companies = [String]()
    var symbols = [String]()
    var prices = [String]()
    var row = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStock()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("StockTableViewCell", owner: self)?.first as! StockTableViewCell
        
        cell.lblCompany.text = companies[indexPath.row]
        cell.lblSymbol.text = symbols[indexPath.row]
        cell.lblPrice.text = prices[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.row = indexPath.row
        performSegue(withIdentifier: "segueDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetails" {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.symbol = symbols[self.row]
        }
    }
    
    func getStock() {
            var url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/allstocks"
            AF.request(url).responseJSON { responseData in
                if responseData.error != nil {
                    print(responseData.error!)
                    return
                }
                
                let stockData = JSON(responseData.data as Any)
//                print(stockData)
                self.companies = [String]()
                self.symbols = [String]()
                self.prices = [String]()
                
                for stock in stockData {
                    let stockJSON = JSON(stock.1)
                    let company = stockJSON["CompanyName"].stringValue
                    let symbol = stockJSON["Symbol"].stringValue
                    let price = stockJSON["Price"].stringValue
                    
                    self.companies.append(company)
                    self.symbols.append(symbol)
                    self.prices.append(price)
                }
                
                self.tblView.reloadData()
            }
        }

}

