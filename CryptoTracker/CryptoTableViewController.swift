//
//  CryptoTableViewController.swift
//  CryptoTracker
//
//  Created by Justin Hollis on 8/11/18.
//  Copyright © 2018 Justin Hollis. All rights reserved.
//

import UIKit

private let headerHeight : CGFloat = 100.0
private let networthHeight : CGFloat = 45.0


class CryptoTableViewController: UITableViewController, CoinDataDelegate {
    
    var amountLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoinData.shared.delegate = self
        CoinData.shared.getPrices()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        CoinData.shared.delegate = self
        tableView.reloadData()
        displayNetWorth()
    }
    
    func newPrices() {
        tableView.reloadData()
        displayNetWorth()
    }
    
    func createHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: headerHeight))
        headerView.backgroundColor = UIColor.white
        let networthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: networthHeight))
        networthLabel.text = "My Crypto Net Worth"
        networthLabel.textAlignment = .center
        headerView.addSubview(networthLabel)
        
        amountLabel.frame = CGRect(x: 0, y: networthHeight, width: view.frame.size.width, height: headerHeight - networthHeight)
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont.boldSystemFont(ofSize: 60.0)
        headerView.addSubview(amountLabel)
        
        displayNetWorth()
        
        return headerView
    }
    
    func displayNetWorth() {
        amountLabel.text = CoinData.shared.netWorthAsString()
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return CoinData.shared.coins.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let coin = CoinData.shared.coins[indexPath.row]
        
        if coin.amount != 0.0 {
            cell.textLabel?.text = "\(coin.symbol)  -  \(coin.priceAsString())   -   \(coin.amount)"
        } else {
            cell.textLabel?.text = "\(coin.symbol)  -  \(coin.priceAsString())"
        }
        cell.imageView?.image = coin.image


         // Configure the cell...

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coinVC = CoinViewController()
        coinVC.coin = CoinData.shared.coins[indexPath.row]
        navigationController?.pushViewController(coinVC, animated: true)
    }

}
