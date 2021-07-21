//
//  EpisodeInfoViewController.swift
//  RicknMortyTrial
//
//  Created by Henit Work on 21/07/21.
//

import UIKit
import Kingfisher

class EpisodeInfoViewController: UIViewController, UIGestureRecognizerDelegate {

    var episodetitle = ""
    var aireddate = ""
    var seasontitle = ""
    var characterURLs : [String] = []
    var characters : [CharacterModel] = []
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var seasonTitle: UILabel!
    @IBOutlet weak var airedOn: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            for characterURL in self.characterURLs{
                self.loadEpisodeCharacters(for: characterURL)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(characterURLs)
        episodeTitle.text = episodetitle
        seasonTitle.text = seasontitle
        airedOn.text = aireddate
        charactersCollectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        charactersCollectionView.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.charactersCollectionView.reloadData()
        }
        
        
        
       
    
        // Do any additional setup after loading the view.
    }
    
    func loadEpisodeCharacters(for url : String){
                
                let url = URL(string: url)
                
                guard let downloadURL = url else { return }
                
                URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
                    guard let data = data, error == nil, urlResponse != nil else{
                        print("something is wrong")
                        
                        return
                    }
                    
                    do{
                        let decoder = JSONDecoder()
                        let characterInfo = try decoder.decode(CharacterModel.self, from: data)
                        self.characters.append(characterInfo)
                        return
                }
                catch
                {
                   print("somethimg is wrong")
                }
                    
            }.resume()
            
        }
    
}

extension EpisodeInfoViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = charactersCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        cell.charName.text = characters[indexPath.row].name
        let resourse = ImageResource(downloadURL: URL(string: characters[indexPath.row].image)!)
        cell.charImage.kf.setImage(with: resourse)
        return cell
    }


}
