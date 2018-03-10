//
//  AddCustomerDetails.swift
//  HotStarTask-Anand
//
//  Created by Anand Nimje on 10/03/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import UIKit

protocol AddCustomerDelegate {
    func getUserDetails(details: UserModel)
}

class AddCustomerDetails: UIViewController {

    var delegate: AddCustomerDelegate?
    
    @IBOutlet weak var textUserName: UITextField!
    @IBOutlet weak var textMobbileNumber: UITextField!
    @IBOutlet weak var textTotalSeats: UITextField!
    @IBOutlet weak var buttonSave: UIButton!{
        didSet{
            buttonSave.layer.cornerRadius = 5.0
        }
    }
    
    @IBOutlet weak var buttonCancel: UIButton!{
        didSet{
            buttonCancel.layer.cornerRadius = 5.0
        }
    }
    
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Adding User Details
    @IBAction func actionSaveDetails(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true) { [weak self] in
            self?.passUserDetails()
        }
    }
    
    private func passUserDetails(){
        delegate?.getUserDetails(details: UserModel(name: textUserName.text ?? "",
                                                    mobile: textMobbileNumber.text ?? "",
                                                    totalSeats: textTotalSeats.text ?? ""))
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
