//
//  UserModel.swift
//  HotStarTask-Anand
//
//  Created by Anand Nimje on 10/03/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import Foundation


struct UserModel {
    var name: String
    var mobile: String
    var totalSeats: String
}

struct UserDetails {
    var name: String
    var mobile: String
    var totalSeats: String
    
    init(_ dic: [String: Any]) {
        self.name = dic[BookingKey.name] as? String ?? ""
        self.mobile = dic[BookingKey.mobile] as? String ?? ""
        self.totalSeats = dic[BookingKey.seats] as? String ?? ""
    }
}
