//
//  MKDCountryTableViewCell.swift
//  MapKitDemo
//
//  Created by Robin Sun on 28/06/2016.
//  Copyright © 2016 Robin Sun. All rights reserved.
//

import UIKit

class MKDCountryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblContinent: UILabel!
    
    var countryModel:MKDCountryModel? {
        didSet {
            lblCountryName.text = countryModel?.name ?? ""
            lblContinent.text = countryModel?.continent ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
