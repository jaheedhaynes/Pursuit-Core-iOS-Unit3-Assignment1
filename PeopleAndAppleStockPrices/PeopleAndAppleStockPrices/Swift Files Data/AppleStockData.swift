//
//  appleStockData.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jaheed Haynes on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct AppleStockInfo {
    let date: String
    let open: String
    let close: String
}


//extension AppleStockInfo {
//
//    static func getStockInfo() -> [UserInfoData] {
//        var users = [UserInfoData]()
//
//        guard let sourceURL = Bundle.main.url(forResource: "userInfo", withExtension: "json")
//            else {
//                fatalError()
//        }
//        do {
//            let data = try Data(contentsOf: sourceURL)
//            let userData = try JSONDecoder().decode(AppleStockInfo.self, from: data)
//
//            users = userData
//
//        } catch {
//           fatalError("something went wrong")
//        }
//        return users
//    }
//}
