//
//  AddressCell.swift
//  totvs-contacts-test
//
//  Created by Francesco Pretelli on 30/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import SDWebImage
import UIKit

class AddressCell: UITableViewCell {
    
    @IBOutlet weak var userCountry: UILabel!
    @IBOutlet weak var userState: UILabel!
    @IBOutlet weak var userZipCode: UILabel!
    @IBOutlet weak var userCity: UILabel!
    @IBOutlet weak var userAddr3: UILabel!
    @IBOutlet weak var userAddr2: UILabel!
    @IBOutlet weak var userAddr1: UILabel!
    
    func updateData(data:Address){
        userCountry.text = data.country
        userState.text = data.state
        userZipCode.text = String(data.zipcode)
        userCity.text = data.city
        userAddr3.text = data.address3
        userAddr2.text = data.address2
        userAddr1.text = data.address1
    }
}