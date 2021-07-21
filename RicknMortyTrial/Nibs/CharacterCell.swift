//
//  CharacterCell.swift
//  RicknMortyTrial
//
//  Created by Henit Work on 20/07/21.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var characterIndex: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var CharacterTitle: UILabel!
    let colors : [CGColor] = [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        characterImage.layer.cornerRadius = 50
        characterImage.layer.borderWidth = 4
        characterImage.layer.borderColor = colors.randomElement()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
