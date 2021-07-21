//
//  ShowLocationViewController.swift
//  RicknMortyTrial
//
//  Created by Henit Work on 21/07/21.
//

import UIKit
import Kingfisher

class ShowLocationViewController: UIViewController {

    @IBOutlet weak var locationCollectionView: UICollectionView!
    @IBOutlet weak var locationSubtitle: UILabel!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    
    var locationtitle = ""
    var subtitle = ""
    var residentURLs : [String] = []
    var residents : [CharacterModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            for residentURL in self.residentURLs{
                self.loadEpisodeCharacters(for: residentURL)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTitle.text = locationtitle
        locationSubtitle.text = subtitle
        
        imageBackground.layer.cornerRadius = 75
        locationCollectionView.dataSource = self
        locationCollectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.locationCollectionView.reloadData()
        }

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
                        self.residents.append(characterInfo)
                        return
                }
                catch
                {
                   print("somethimg is wrong")
                }
                    
            }.resume()
            
        }
    


}

extension ShowLocationViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        residents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        cell.charName.text = residents[indexPath.row].name
        let resourse = ImageResource(downloadURL: URL(string: residents[indexPath.row].image)!)
        cell.charImage.kf.setImage(with: resourse)
        return cell
    }
    
    
}
