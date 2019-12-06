//
//  appleStockData.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jaheed Haynes on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct AppleStockInfo: Codable {
    let date: String
    let label: String
    let open: Double
    let close: Double
}


//----------------------------------------------------------------------------------------------------------
// MARK:- Extensions

extension AppleStockInfo {
    
    static func getStocks() -> [AppleStockInfo] {
        
        var stock = [AppleStockInfo]()
        guard let file = Bundle.main.url(forResource: "appleStockInfo", withExtension: "json") else {
            fatalError("can't locate json data")
        }
        do {
            let data = try Data(contentsOf: file)
            
            let stockData = try JSONDecoder().decode([AppleStockInfo].self, from: data)
            stock = stockData
            
        } catch {
            fatalError("\(error)")
        }
        
        return stock
    }
    
    //---------------------------------------------------------------------------------------
    // This seperates each month into its on section
    
    static func getStockSections() -> [[AppleStockInfo]] {
        
        let stocks = getStocks()
        
     
        let monthName: Set<String> = Set(stocks.map { $0.label })
        
        var sectionsArr = Array(repeating: [AppleStockInfo](), count: monthName.count)
        
        var currentIndex = 0
        
        var currentMonth = stocks.first?.label.components(separatedBy: " ").first ?? ""
        
        //---------------------------------------------------------------------------------------
        // This seperates each date within each month where there is an open & close
        
        for stock in stocks {
            let month = stock.label.components(separatedBy: " ").first ?? ""
            
            if month == currentMonth {
                sectionsArr[currentIndex].append(stock)
                
            } else {
                currentIndex += 1
                currentMonth = stock.label.components(separatedBy: " ").first ?? ""
                sectionsArr[currentIndex].append(stock)
            }
        }
        return sectionsArr
        
        //---------------------------------------------------------------------------------------
        
    }
}
