//
//  ViewController.swift
//  totvs-contacts-test
//
//  Created by Francesco Pretelli on 30/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import UIKit
import ExpandingMenu
import MessageUI

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tableview: UITableView!
    var pullToRefresh = UIRefreshControl()
    var completeList:[User] = [User]()
    var users:[User] = [User]()
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        searchBar.delegate = self
        let textFieldInsideSearchBar = searchBar.valueForKey("searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.whiteColor()
        setupPullToRefresh()
        setupMenuButton()
        navigationItem.hidesBackButton = true
        
        //startup update
        if Reachability.isConnectedToNetwork(){
            pullToRefresh.beginRefreshing()
            tableview.setContentOffset(CGPoint(x: 0, y: -pullToRefresh.frame.size.height), animated: true)
            updateContacts(nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //MARK: Setup Functions

    func setupMenuButton(){        
        let menuButtonSize: CGSize = CGSize(width: 64.0, height: 64.0)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPointZero, size: menuButtonSize), centerImage: UIImage(named: "menu")!, centerHighlightedImage: UIImage(named: "menu-highlighted")!)
        menuButton.center = CGPointMake(self.view.bounds.width - 32.0, self.view.bounds.height - 48.0)
        view.addSubview(menuButton)
        
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Logout", image: UIImage(named: "logout")!, highlightedImage: UIImage(named: "logout-highlighted")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
            self.navigationController?.popViewControllerAnimated(false)
        }
        
        let item2 = ExpandingMenuItem(size: menuButtonSize, title: "Hire Me :-)", image: UIImage(named: "hire")!, highlightedImage: UIImage(named: "hire-highlighted")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
           self.sendEmail()
        }
    
        menuButton.addMenuItems([item1, item2])
    }
    
    func setupPullToRefresh(){
        pullToRefresh.attributedTitle = NSAttributedString(string: NSLocalizedString("Downloading Contacts", comment: ""))
        pullToRefresh.addTarget(self, action: "updateContacts:", forControlEvents: UIControlEvents.ValueChanged)
        tableview.addSubview(pullToRefresh)
    }
    
    func sendEmail(){
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["aliasHiring@timelabs.io"])
        mailComposerVC.setSubject("We want to hire you!")
        mailComposerVC.setMessageBody("Great news! Your app is awesome and we want you to join the best team in the world!", isHTML: false)

        
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposerVC, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: data handling
    
    func updateContacts(sender:AnyObject?){
        if !Reachability.isConnectedToNetwork(){
            pullToRefresh.endRefreshing()
            return
        }
        
        APIservice.sharedInstance.getUsers(){ (result:[User]) in
            self.users = result
            self.completeList = result
            self.tableview.reloadData()
            self.pullToRefresh.endRefreshing()
        }
    }
    
    func searchUser(text:String){
        users = completeList.filter( { ($0.name?.containsString(text))!})
        tableview.reloadData()
    }
    
    //MARK: Search Bar Delegate functions
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            searchUser(searchText)
        }
        else {
            users = completeList
            tableview.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        users = completeList
        tableview.reloadData()
    }
    
    //MARK: TableView Delegate Functions
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
         searchBar.resignFirstResponder()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! ContactCell
        let user = users[indexPath.row]
        cell.updateData(user)
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale
        indexPath.row % 2 == 0 ? (cell.backgroundColor = UIColor(hex: 0x0066C2)) : (cell.backgroundColor = UIColor(hex: 0x267AC7))
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowContactSegue" {
            if let destination = segue.destinationViewController as? ContactDetailViewController {                
                if let indx = tableview.indexPathForSelectedRow?.row {
                   destination.currentUser = users[indx]
                }
                
            }
        }
    }
    
}

