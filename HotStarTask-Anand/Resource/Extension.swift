//
//  Extension.swift
//  HotStarTask-Anand
//
//  Created by Anand Nimje on 10/03/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func showAlertWithMessage(_ message: String, with completion: (() -> Void)?){
        let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        let delay = 3.0 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            alertController.dismiss(animated: true, completion: nil)
            completion?()
        })
    }
}


extension String {
    
    public var isNotEmpty: Bool {
        return !isEmpty
    }
    
    var trim: String {
        if self.isNotEmpty {
            return self.trimmingCharacters(in: CharacterSet.whitespaces)
        }else{
            return ""
        }
    }
}
