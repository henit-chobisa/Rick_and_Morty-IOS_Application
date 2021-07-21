//
//  EpisodeCollectionViewCell.swift
//  RicknMortyTrial
//
//  Created by Henit Work on 21/07/21.
//

import UIKit
import Kingfisher

class EpisodeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var episodeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configureCell(with episode : EpisodeModel){
        episodeName.text = episode.name
        episodeImage.image = #imageLiteral(resourceName: "launchscreen")
    }

}
