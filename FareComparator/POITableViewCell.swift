//
//  POITableViewCell.swift
//  FareComparator
//
//  Created by BK on 15/10/2016.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import UIKit

class POITableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var poiModal: AMapPOI? {
        didSet {
            if let poi = poiModal {
                nameLabel.text = poi.name
                typeLabel.text = poi.type
                addressLabel.text = poi.address
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
