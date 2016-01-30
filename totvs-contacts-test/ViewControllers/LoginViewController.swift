//
//  LoginViewController.swift
//  totvs-contacts-test
//
//  Created by Francesco Pretelli on 30/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTfield: UITextField!
    @IBOutlet weak var passwordTfiled: UITextField!
    
    @IBOutlet weak var loginBtn: TKTransitionSubmitButton!
    var btn: TKTransitionSubmitButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        setupViews()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func OnLoginBtnTouchUpInside(sender: AnyObject) {
        loginBtn.animate(1, completion: { () -> () in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let contactsVC = storyboard.instantiateViewControllerWithIdentifier("ContactsVC") as? ContactsViewController
            self.navigationController?.pushViewController(contactsVC!, animated: false)
        })
    }
   
    func setupViews(){
        //adding lines below textfield
        let usernameBottomLine = UIView(frame: CGRectMake(usernameTfield.frame.origin.x, usernameTfield.frame.origin.y + usernameTfield.frame.height, usernameTfield.frame.size.width, 0.5))
        usernameBottomLine.backgroundColor = UIColor.whiteColor()
        usernameBottomLine.opaque = true        
        
        let passwordBottomLine = UIView(frame: CGRectMake(passwordTfiled.frame.origin.x, passwordTfiled.frame.origin.y + passwordTfiled.frame.height, passwordTfiled.frame.size.width, 0.5))
        passwordBottomLine.backgroundColor = UIColor.whiteColor()
        passwordBottomLine.opaque = true
        
        view.addSubview(usernameBottomLine)
        view.addSubview(passwordBottomLine)
        
        //styling button
        loginBtn.layer.borderColor = UIColor.whiteColor().CGColor
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.cornerRadius = 23
        
        //changing placeholder color
        let str = NSAttributedString(string: "username", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        usernameTfield.attributedPlaceholder = str
        
        let str2 = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        passwordTfiled.attributedPlaceholder = str2
    }
    
}