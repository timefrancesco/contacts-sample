//
//  HeaderContainerView.swift
//  totvs-contacts-test
//
//  Created by Francesco Pretelli on 30/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SafariServices

class HeaderContainerView: UIViewController  {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPosition: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    var currentUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateUserData()
    }
    
    @IBAction func onBackButtonTouchUpInside(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
   
    @IBAction func onWebsiteBtnTouchUpInside(sender: AnyObject) {
        let svc = SFSafariViewController(URL: NSURL(string: "http://"+currentUser.homePage! )!)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    
    func updateUserData(){
        userName.text = currentUser.name
        userPosition.text = currentUser.position
        userCompany.text = (currentUser.companyDetails?.name)! + " - " + (currentUser.companyDetails?.location)!
        userAge.text = String(currentUser.age) + " years old"
        userImage.sd_setImageWithURL(NSURL(string: currentUser.imageUrl!),placeholderImage:  UIImage(named:"User"),  options: [ SDWebImageOptions.RetryFailed ])
    }
}