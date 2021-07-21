//
//  EpisodeViewController.swift
//  RicknMortyTrial
//
//  Created by Henit Work on 20/07/21.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    
    @IBOutlet weak var episodeTableView: UITableView!
    
    var episodes : EpisodeInfoModel? = nil
    var seasonFilter : [[EpisodeModel]] = []
    
    struct customEpisodePush {
        var season : Int
        var episodeInfo : EpisodeModel
    }
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        getEpisodes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        let micImage = UIImage(systemName: "mic.fill")
        searchController.searchBar.setImage(micImage, for: .bookmark, state: .normal)
        searchController.searchBar.showsBookmarkButton = true
        
        episodeTableView.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeTableViewCell")
        episodeTableView.dataSource = self
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.episodeTableView.reloadData()
        }
        episodeTableView.rowHeight = 350
        episodeTableView.allowsSelection = false
        
    
    
    }
    
    func getEpisodes(){
        
        let url = URL(string: "https://rickandmortyapi.com/api/episode")
        
        guard let downloadURL = url else { return }
        
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else{
                print("something is wrong")
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let episodeInfo = try decoder.decode(EpisodeInfoModel.self, from: data)
                self.episodes = episodeInfo
                self.filterBySeason()
            
                //Tried if the following is working or Not
                
            }catch{
               print("something is wrong")
            }
        }.resume()
        episodeTableView.reloadData()
    }
    
    
    
    func filterBySeason(){
        
        if let episodes = episodes {
            var Season1 : [EpisodeModel] = []
            var Season2 : [EpisodeModel] = []
            for episode in episodes.results {
                if episode.episode[2] == "1"{
                    Season1.append(episode)
                }
                else {
                    Season2.append(episode)
                }
            }
            seasonFilter.append(Season1)
            seasonFilter.append(Season2)
            
        }
    }
    
}

extension EpisodeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasonFilter.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = episodeTableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell") as! EpisodeTableViewCell
        cell.configureTableView(with: seasonFilter[indexPath.row], season: "Season - \(indexPath.row + 1)")
        if indexPath.row == 0 {
            cell.didSelectCollectionCell = { [weak self] indexPath in
                self!.performSegue(withIdentifier: "toEpisodeInfo", sender: customEpisodePush(season: 1, episodeInfo: self!.seasonFilter[0][indexPath.row] ) )
            }
        }
        else {
            cell.didSelectCollectionCell = { [weak self] indexPath in
                self!.performSegue(withIdentifier: "toEpisodeInfo", sender: customEpisodePush(season: 2, episodeInfo: self!.seasonFilter[1][indexPath.row]))
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEpisodeInfo"{
            if let vc = segue.destination as? EpisodeInfoViewController{
                if let sender = sender as? customEpisodePush {
                    vc.episodetitle = sender.episodeInfo.name
                    vc.aireddate = sender.episodeInfo.airDate
                    vc.seasontitle = "Season \(sender.season) Episode \(sender.episodeInfo.id)"
                    vc.characterURLs = sender.episodeInfo.characters
                }
            }
        }
    }
    
    
    
    
}



extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
