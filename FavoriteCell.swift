//
//  FavoriteCell.swift
//  AuditionCity
//
//  Created by Paul Vagner on 11/26/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var faceShot: UIImageView!
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
