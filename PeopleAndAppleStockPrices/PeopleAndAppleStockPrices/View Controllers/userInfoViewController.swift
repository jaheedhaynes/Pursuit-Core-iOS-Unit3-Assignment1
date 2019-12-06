//
//  userInfoViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jaheed Haynes on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

enum SearchScope {
    case first
}

class userInfoViewController: UIViewController {
    
    @IBOutlet weak var userInfoTable: UITableView!
    @IBOutlet weak var userSearchBar: UISearchBar!
    
    var users = [UserInfoData]() {
        didSet {
            userInfoTable.reloadData()
        }
    }
    
    var currentScope = SearchScope.first
    
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .first:
                users = PeopleInfo.getUserInfo().filter {$0.name.first.lowercased().contains(searchQuery.lowercased())}
                
            }
        }
    }
    
    //--------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        userInfoTable.dataSource = self
        userSearchBar.delegate = self
        
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
//MARK: EXTENSION (DataSource for TableView)

extension userInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = userInfoTable.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath)
        
        let user = users[indexPath.row]
        
        // Code Below retrieves the images to populate the initial tableView
        userCell.textLabel?.text = user.name.first.uppercased()
        userCell.detailTextLabel?.text = user.location.city.uppercased()
        ImageClient.fetchImage(for: user.picture.large) {  (result) in
            switch result {
            case .failure(let error):
                print("error: \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    userCell.imageView?.image = image
                    
                }
            }
        }
        return userCell
    }
    
}

//-------------------------------------------------------------------------
//MARK: EXTENSION (SEARCH BAR METHODS)

extension userInfoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // dismiss the keyboard
        searchBar.resignFirstResponder()
        
    }
    
    // real time search as user types
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            
            loadData()
            return
        }
        searchQuery = searchText
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = SearchScope.first
            
        default:
            print("not a valid search scope")
        }
        
    }
}
