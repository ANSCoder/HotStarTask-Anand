//
//  AppDelegate.swift
//  HotStarTask-Anand
//
//  Created by Anand Nimje on 10/03/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    enum Controllers : String{
        case LoginVC
        case ReceptionistVC
        case UserVC
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.sharedManager().enable = true
        
        Thread.sleep(forTimeInterval: 0.2)
        
        checkUserType()
        return true
    }

    fileprivate func checkUserType(){
        switch Defaults.getUserStatus() {
        case .receptionist:
            gotoMainView(.ReceptionistVC)
        case .customer:
            gotoMainView(.UserVC)
        default:
            gotoMainView(.LoginVC)
        }
    }
    
    func gotoMainView(_ view: Controllers){
        let rootViewController = self.window!.rootViewController as! UINavigationController
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = mainStoryboard.instantiateViewController(withIdentifier: view.rawValue)
        rootViewController.pushViewController(destination, animated: false)
    }

}

