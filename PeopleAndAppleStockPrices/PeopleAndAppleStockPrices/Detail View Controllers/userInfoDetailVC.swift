//
//  userInfoDetailVC.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jaheed Haynes on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class userInfoDetailVC: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var userInfo: UserInfoData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    func updateUI() {
        guard let userInfo = userInfo else {
            fatalError("error)")
        }
        
        emailLabel.text = userInfo.email
        nameLabel.text = userInfo.name.first
        cityLabel.text = userInfo.location.city
        
        ImageClient.fetchImage(for: userInfo.picture.large) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("error: \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.userImage.image = image
                    
                }
            }
        }
        
    }
    
}
