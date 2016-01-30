//
//  KeyValueCell.swift
//  totvs-contacts-test
//
//  Created by Francesco Pretelli on 30/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import SDWebImage
import UIKit

class KeyValueCell: UITableViewCell {
    
    @IBOutlet weak var keyLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    func updateData(key:String, value:String){
        keyLbl.text = key
        valueLbl.text = value
    }
}