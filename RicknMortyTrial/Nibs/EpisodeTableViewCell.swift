//
//  EpisodeTableViewCell.swift
//  RicknMortyTrial
//
//  Created by Henit Work on 21/07/21.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    var didSelectCollectionCell : ((IndexPath) -> Void)?
    @IBOutlet weak var seasonName: UILabel!
    @IBOutlet weak var episodeCollectionView: UICollectionView!
    var episodes : [EpisodeModel] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        episodeCollectionView.register(UINib(nibName: "EpisodeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EpisodeCollectionViewCell")
        episodeCollectionView.dataSource = self
        episodeCollectionView.delegate = self
        
        
    }
    
    public func configureTableView(with episodes : [EpisodeModel], season : String){
        self.episodes = episodes
        self.seasonName.text = season
        episodeCollectionView.reloadData()
    }
}

extension EpisodeTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCollectionCell?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = episodeCollectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeCollectionViewCell", for: indexPath) as! EpisodeCollectionViewCell
        cell.configureCell(with: episodes[indexPath.row])
        return cell
    }
    
    
}
