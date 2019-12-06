//
//  appleStockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jaheed Haynes on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class appleStockViewController: UIViewController {
    
    @IBOutlet var appleStockTableView: UITableView!
    
    var appleStockArray = [[AppleStockInfo]]() {
        didSet {
            appleStockTableView.reloadData()
        }
    }
    
//----------------------------------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appleStockTableView.dataSource = self
        
        loadData()
        
        }
    
//----------------------------------------------------------------------------------------------------------
    
    func loadData() {
        appleStockArray = AppleStockInfo.getStockSections()
    }
    
    
    func getAverage(for arr: [AppleStockInfo]) -> Double {
        var sum: (Double) = 0.0
        var average = Double()
        for stock in arr {
            sum += stock.open
        }
        
        average = sum / Double(arr.count)
        
        return average
    }

//----------------------------------------------------------------------------------------------------------

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let appleStockVC = segue.destination as? appleStockDetailVC,
            let indexPath = appleStockTableView.indexPathForSelectedRow else {
                return
        }
        appleStockVC.stock = appleStockArray[indexPath.section][indexPath.row]
    }
    
    
}

//----------------------------------------------------------------------------------------------------------
// MARK:- Extensions

extension appleStockViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appleStockArray[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "appleStockCell", for: indexPath)
        
        let stock = appleStockArray[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = "\(stock.date)"
        cell.detailTextLabel?.text = "\(stock.open.description)"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return appleStockArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let average = getAverage(for: appleStockArray[section])
        let month = appleStockArray[section].first?.label.components(separatedBy: " ").first ?? ""
        let year = appleStockArray[section].first?.label.components(separatedBy: " ").last ?? ""
        
        // this line was partially from stackOverFlow
        // unsure as to what its actually doing but it works
        return "\(month) - 20\(year), average open: \(String(format: "%.2f", average))"
    }
    
    
    
}
