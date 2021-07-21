//
//  LocationsTableViewCell.swift
//  RicknMortyTrial
//
//  Created by Henit Work on 21/07/21.
//

import UIKit

class LocationsTableViewCell: UITableViewCell {

    @IBOutlet weak var locationIndex: UILabel!
    @IBOutlet weak var locationTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    
}
