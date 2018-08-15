//
//  CryptoTableViewController.swift
//  CryptoTracker
//
//  Created by Justin Hollis on 8/11/18.
//  Copyright © 2018 Justin Hollis. All rights reserved.
//

import UIKit

class CryptoTableViewController: UITableViewController, CoinDataDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoinData.shared.delegate = self
        CoinData.shared.getPrices()

    }
    
    func newPrices() {
        tableView.reloadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return CoinData.shared.coins.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let coin = CoinData.shared.coins[indexPath.row]
        
        cell.textLabel?.text = "\(coin.symbol)  -  \(coin.priceAsString())"
        cell.imageView?.image = coin.image

         // Configure the cell...

        return cell
    }
 

}
