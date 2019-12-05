//
//  userInfoViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jaheed Haynes on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class userInfoViewController: UIViewController {
    
    @IBOutlet weak var userInfoTable: UITableView!
    
    var users = [UserInfoData]() {
        didSet {
            userInfoTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        userInfoTable.dataSource = self
        
    }
    
    func loadData() {
        users = PeopleInfo.getUserInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userInfo = segue.destination as? userInfoDetailVC,
            let indexPath = userInfoTable.indexPathForSelectedRow
            
            else    {
                fatalError()
        }
        
        let user = users[indexPath.row]
        userInfo.userInfo = user
    }
}

//-------------------------------------------------------------------------

extension userInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = userInfoTable.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath)
        
        let user = users[indexPath.row]
        
        userCell.textLabel?.text = user.name.first
        
        return userCell
    }
    
}
