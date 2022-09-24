//
//  TableViewClassTableViewController.swift
//  MyFavourite Food
//
//  Created by Shaoshuai Xu on 9/24/22.
//

import UIKit

class TableViewClassTableViewController: UITableViewController {
    
    let food = ["Fried Rice", "Mapo Toufu", "Fried Frice", "Coke Colar"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return food.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = food[indexPath.row]

        return cell
    }
}
