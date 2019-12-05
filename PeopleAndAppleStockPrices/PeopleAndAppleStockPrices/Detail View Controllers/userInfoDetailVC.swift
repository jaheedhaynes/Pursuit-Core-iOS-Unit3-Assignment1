//
//  userInfoDetailVC.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jaheed Haynes on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class userInfoDetailVC: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var userInfo: UserInfoData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        
    }
    func updateUI() {
        nameLabel.text = userInfo?.first
        emailLabel.text = userInfo?.email
//        cityLabel.text = userInfo?.city
       }


}
