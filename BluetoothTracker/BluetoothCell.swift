//
//  BluetoothCell.swift
//  BluetoothTracker
//
//  Created by Nolan Fuchs on 1/30/19.
//  Copyright © 2019 Nolan Fuchs. All rights reserved.
//

import UIKit

class BluetoothCell: UITableViewCell {
    
    @IBOutlet weak var peripheralName: UILabel!
    @IBOutlet weak var rssiName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
