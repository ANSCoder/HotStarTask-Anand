//
//  UserVC.swift
//  HotStarTask-Anand
//
//  Created by Anand Nimje on 10/03/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import UIKit

class UserVC: UIViewController {

    var userDic = Defaults().getCustomerDetails
    
    @IBOutlet weak var labelname: UILabel!
    @IBOutlet weak var labelMobile: UILabel!
    @IBOutlet weak var labelSeats: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let model = UserDetails(userDic)
        labelname.text = "Name: " + model.name
        labelMobile.text = "Mobile: " + model.mobile
        labelSeats.text = model.totalSeats + " People"
    }
    
    @IBAction func acrtionLogout(_ sender: Any) {
        Defaults().clearUserData()
        navigationController?.popToRootViewController(animated: true)
    }

}
