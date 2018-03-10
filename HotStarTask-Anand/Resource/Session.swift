//
//  Session.swift
//  HotStarTask-Anand
//
//  Created by Anand Nimje on 10/03/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import Foundation


struct Defaults {
    
    static let userSessionKey = "com.save.usersession"
    static let customerSessionKey = "com.save.usersession"
    static let userType = "com.save.userType"
    
    
    public enum User: String{
        case customer, receptionist, unKnown
    }
    
    fileprivate static var defaults = UserDefaults.standard
    
    static func setUserStatus(user: User){
        defaults.removeObject(forKey: Defaults.userType)
        defaults.set(user.rawValue, forKey: Defaults.userType)
        defaults.synchronize()
    }
    
    static func getUserStatus() -> User{
        guard let type = defaults.string(forKey: Defaults.userType) else {
            return .unKnown
        }
        guard let userType = User(rawValue: type) else {
            return .unKnown
        }
        return userType
    }
    
    var saveNameAndAddress = { (userDetails: [[String: String]]) in
        UserDefaults.standard.set(userDetails, forKey: userSessionKey)
        defaults.synchronize()
    }
    
    var saveCustomersDetails = { (userDetails: [String: String]) in
        UserDefaults.standard.set(userDetails, forKey: customerSessionKey)
        defaults.synchronize()
    }
    
    var getCustomerDetails = UserDefaults.standard.value(forKey: customerSessionKey) as? [String: String] ?? [:]
    
    
    //MARK: - Get user List
    var getUserDetails = UserDefaults.standard.value(forKey: userSessionKey) as? [[String: String]] ?? []
    
    //MARK: - Logout Process
    func clearUserData(){
        //UserDefaults.standard.removeObject(forKey: Defaults.userSessionKey)
        Defaults.setUserStatus(user: .unKnown)
        Defaults.defaults.synchronize()
    }
}
