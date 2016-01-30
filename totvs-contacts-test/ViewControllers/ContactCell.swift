//
//  ContactCell.swift
//  totvs-contacts-test
//
//  Created by Francesco Pretelli on 30/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import SDWebImage
import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactCompany: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    
    func updateData(user:User){
        contactName.text = user.name
        contactCompany.text = user.companyDetails?.name
        contactImage.sd_setImageWithURL(NSURL(string: user.imageUrl!),placeholderImage:  UIImage(named:"User"),  options: [ SDWebImageOptions.RetryFailed ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contactImage.layer.cornerRadius = contactImage.frame.width / 2
    }
    
}
