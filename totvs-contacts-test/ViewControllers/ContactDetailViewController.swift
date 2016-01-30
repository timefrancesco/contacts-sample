//
//  ContactDetailViewController.swift
//  totvs-contacts-test
//
//  Created by Francesco Pretelli on 30/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

enum UserDetailsSection:Int{
    case PHONE = 0
    case EMAIL
    case ADDRESS
    case END
}

class ContactDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    var currentUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let headerVC = childViewControllers[childViewControllers.count-1] as! HeaderContainerView
        headerVC.currentUser = currentUser
        tableView.reloadData()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //MARK: TableView Delegate Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return UserDetailsSection.END.rawValue
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell: AnyObject!
        
        switch(indexPath.section){
        case UserDetailsSection.PHONE.rawValue:
            let currentCell = tableView.dequeueReusableCellWithIdentifier("KeyValueCell", forIndexPath: indexPath) as! KeyValueCell
            currentCell.updateData(currentUser.phone[indexPath.row].type!, value: currentUser.phone[indexPath.row].number!)
            cell = currentCell
            break
        case UserDetailsSection.EMAIL.rawValue:
            let currentCell = tableView.dequeueReusableCellWithIdentifier("KeyValueCell", forIndexPath: indexPath) as! KeyValueCell
            currentCell.updateData(currentUser.emails[indexPath.row].label!, value: currentUser.emails[indexPath.row].email!)
            cell = currentCell
            break
        case UserDetailsSection.ADDRESS.rawValue:
            let currentCell = tableView.dequeueReusableCellWithIdentifier("AddressCell", forIndexPath: indexPath) as! AddressCell
            currentCell.updateData(currentUser.address[indexPath.row])
            cell = currentCell
            break
        default:
            break
        }
        return cell as! UITableViewCell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        
        switch(section){
        case UserDetailsSection.PHONE.rawValue:
            title = "PHONE"
            break
        case UserDetailsSection.EMAIL.rawValue:
            title = "EMAIL"
            break
        case UserDetailsSection.ADDRESS.rawValue:
            title = "ADDRESS"
            break
        default:
            break
        }
        return title
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 1
        switch(section){
        case UserDetailsSection.PHONE.rawValue:
            num = currentUser.phone.count
            break
        case UserDetailsSection.EMAIL.rawValue:
            num = currentUser.emails.count
            break
        case UserDetailsSection.ADDRESS.rawValue:
            num = currentUser.address.count
            break
        default:
            num = 1
            break
        }
        return num
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var num:CGFloat = 60
        
        switch(indexPath.section){
        case UserDetailsSection.PHONE.rawValue:
            num = 60
            break
        case UserDetailsSection.EMAIL.rawValue:
            num = 60
            break
        case UserDetailsSection.ADDRESS.rawValue:
            num = 120
            break
        default:
            num = 60
            break
        }
        return num
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
