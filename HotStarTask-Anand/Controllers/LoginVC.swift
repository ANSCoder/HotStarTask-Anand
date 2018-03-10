//
//  LoginVC.swift
//  HotStarTask-Anand
//
//  Created by Anand Nimje on 10/03/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import UIKit

struct LoginKey{
    static let receptionistUserId = "receptionist"
    static let receptionistPassword = "1234"
}

class LoginVC: UIViewController {

    
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!{
        didSet{
            buttonLogin.layer.cornerRadius = 5.0
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    //MARK: - Action Login
    @IBAction func actionLogin(_ sender: Any) {

        guard textUsername.text?.count != 0 && textPassword.text?.count != 0 else {
            self.showAlertWithMessage("Please Enter user name", with: nil)
            return
        }
        
        guard (textUsername.text ?? "").trim == LoginKey.receptionistUserId && (textPassword.text ?? "").trim == LoginKey.receptionistPassword else {
            guard checkForCustomer().count != 0 else {
                self.showAlertWithMessage("User Not found.", with: nil)
                return
            }
            Defaults.setUserStatus(user: .customer)
            Defaults().saveCustomersDetails(checkForCustomer()[0])
            let user = self.storyboard?.instantiateViewController(withIdentifier: "UserVC") as! UserVC
            self.navigationController?.pushViewController(user, animated: true)
            return
        }
        Defaults.setUserStatus(user: .receptionist)
        let receptionist = self.storyboard?.instantiateViewController(withIdentifier: "ReceptionistVC") as! ReceptionistVC
        self.navigationController?.pushViewController(receptionist, animated: true)
    }
    
    func checkForCustomer() -> [[String: String]]{
        let userArray = Defaults().getUserDetails
        
        let filter = userArray.filter { dic -> Bool in
            let stringMatch = dic[BookingKey.name]?.lowercased().range(of:(textUsername.text ?? "").trim.lowercased())
            return stringMatch != nil ? true : false
        }
       return filter
    }
    
}
