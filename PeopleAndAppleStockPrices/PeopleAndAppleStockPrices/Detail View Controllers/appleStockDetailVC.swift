//
//  appleStockDetailVC.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jaheed Haynes on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class appleStockDetailVC: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumbUPthumbDownImage: UIImageView!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
    var stock: AppleStockInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        guard let appleStock = stock else { fatalError("could not load stock")
        }
        
        openLabel.text = appleStock.open.description
        closeLabel.text = appleStock.close.description
        dateLabel.text = appleStock.date.description
        
        // if opening stock is less than the closing price than you are given thumbs up image after segue
        // if opening stock is greater than the closing price than you are given thumbs down image after segue

        if appleStock.open < appleStock.close {
            
            view.backgroundColor = .green
           thumbUPthumbDownImage.image = #imageLiteral(resourceName: "thumbsUp")

        } else {
            
            view.backgroundColor = .red
            thumbUPthumbDownImage.image = #imageLiteral(resourceName: "thumbsDown.jpg")
        }
    }

    
}
