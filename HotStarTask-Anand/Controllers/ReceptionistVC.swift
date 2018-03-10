//
//  ReceptionistVC.swift
//  HotStarTask-Anand
//
//  Created by Anand Nimje on 10/03/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import UIKit

class BookingCell: UITableViewCell {
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelMobile: UILabel!
    @IBOutlet weak var labelBookingSeats: UILabel!
    @IBOutlet weak var labelSerialNumber: UILabel!
    
    
}

struct BookingKey {
    static let name = "name"
    static let mobile = "mobile"
    static let seats = "seats"
}


class ReceptionistVC: UIViewController {
    
    @IBOutlet weak var tableWaitingList: UITableView!{
        didSet{
            tableWaitingList.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var labelTotalTable: UILabel!
    @IBOutlet weak var labelOccupiedTable: UILabel!
    @IBOutlet weak var labelInQueue: UILabel!
    
    var arrayOfAllocated = [[String: Any]]()
    var arrayOfQueue = [[String: Any]]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpViewData()
    }
    
    func setUpViewData(){
        //Clear Old Data
        arrayOfAllocated = []
        arrayOfQueue = []
        
        //Adding New Data
        let userArray = Defaults().getUserDetails
        userArray.enumerated().forEach { index, dic in
            if index > 3 {
                arrayOfQueue.append(dic)
            }else {
                arrayOfAllocated.append(dic)
            }
        }
        labelOccupiedTable.text = String(arrayOfAllocated.count)
        labelInQueue.text = String(arrayOfQueue.count)
        tableWaitingList.reloadData()
    }
    
    //MARK: - Add Customer
    @IBAction func actionAddCustomer(_ sender: Any) {
        let addUser = self.storyboard?.instantiateViewController(withIdentifier: "AddCustomerDetails") as! AddCustomerDetails
        addUser.delegate = self
        present(addUser, animated: true, completion: nil)
    }
    
    @IBAction func actionLogout(_ sender: Any) {
        Defaults().clearUserData()
        navigationController?.popToRootViewController(animated: true)
    }
    
}

//MARK: - Table View DataSource Methods
extension ReceptionistVC: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        guard section == 0 else {
            return queueTitle
        }
        return "Allocated"
    }
    
    var queueTitle: String?{
        guard arrayOfQueue.count != 0 else {
            return nil
        }
        return "Queue"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else {
            return arrayOfQueue.count
        }
        return arrayOfAllocated.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard indexPath.section == 0 else {
            return setUpTableViewCell(tableView, indexPath, array: arrayOfQueue)
        }
        return setUpTableViewCell(tableView, indexPath, array: arrayOfAllocated)
    }
    
    func setUpTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath, array: [[String: Any]]) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell") as! BookingCell
        let dic = array[indexPath.row]
        let model = UserDetails(dic)
        cell.labelUsername.text = model.name
        cell.labelMobile.text = model.mobile
        cell.labelBookingSeats.text = model.totalSeats + " People"
        cell.labelSerialNumber.text = String(format: "%d", indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard indexPath.section == 0 else{
                arrayOfQueue.remove(at: indexPath.row)
                updateUserList()
                return
            }
            arrayOfAllocated.remove(at: indexPath.row)
            updateUserList()
        }
    }
    
    func updateUserList(){
        var (first, second) = (arrayOfAllocated, arrayOfQueue)
        first.append(contentsOf: second)
        Defaults().saveNameAndAddress(first as? [[String : String]] ?? [])
        setUpViewData()
    }
    
}

extension ReceptionistVC: AddCustomerDelegate{
    
    func getUserDetails(details: UserModel){
        let dictionary = [BookingKey.name: details.name,
                          BookingKey.mobile: details.mobile,
                          BookingKey.seats: details.totalSeats]
        var userArray = Defaults().getUserDetails
        userArray.append(dictionary)
        Defaults().saveNameAndAddress(userArray)
        setUpViewData()
    }
}


