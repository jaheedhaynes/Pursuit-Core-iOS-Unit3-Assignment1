//
//  userInfoData.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jaheed Haynes on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct PeopleInfo: Codable  {
    let results: [UserInfoData]
}

struct UserInfoData: Codable {
    let location: Location
    let name: Name
    let email: String
    let picture: Image
    
}

struct Location: Codable {
    let city: String
}

struct Name: Codable {
    let first: String
    let last: String
    
    private enum CodingKeys: String, CodingKey {
        case first = "first"
        case last = "last"
        
    }
}

struct Image: Codable {
    let large: String
}

//-------------------------------------------------------------------------

extension PeopleInfo {
    
    static func getUserInfo() -> [UserInfoData] {
        var users = [UserInfoData]()
        
        guard let sourceURL = Bundle.main.url(forResource: "userInfo", withExtension: "json")
            else {
                fatalError()
        }
        do {
            let data = try Data(contentsOf: sourceURL)
            let userData = try JSONDecoder().decode(PeopleInfo.self, from: data)
            
            users = userData.results
            
        } catch {
            fatalError("\(error)")
        }
        return users
    }
    
}
