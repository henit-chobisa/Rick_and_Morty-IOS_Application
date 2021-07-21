//
//  CharacterCollectionViewCell.swift
//  RicknMortyTrial
//
//  Created by Henit Work on 21/07/21.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var charName: UILabel!
    @IBOutlet weak var charImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        charImage.layer.cornerRadius = 33
        // Initialization code
    }

}
