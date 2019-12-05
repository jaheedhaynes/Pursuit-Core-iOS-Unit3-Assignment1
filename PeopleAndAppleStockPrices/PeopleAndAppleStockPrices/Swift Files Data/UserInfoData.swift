//
//  userInfoData.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jaheed Haynes on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ResultsArr: Codable  {
    let results: [UserInfoData]
}

struct UserInfoData: Codable {
    
    let first: String
    let last: String
    let email: String
    let city: [Location]
    
struct Location: Codable {
    
    let city: String
    
    }

    
    static func getUserInfo() -> [UserInfoData] {
        var users = [UserInfoData]()
        
        guard let sourceURL = Bundle.main.url(forResource: "userInfo", withExtension: "json")
            else {
                fatalError()
        }
        do {
            let data = try Data(contentsOf: sourceURL)
            let userData = try JSONDecoder().decode([UserInfoData].self, from: data)
            users = userData
            
        } catch {
            fatalError()
        }
        return users
    }
}
