


//Henit Chobisa

import UIKit
import Kingfisher
import FloatingPanel

class CharacterViewController: UIViewController, UITableViewDelegate {

    let fpcontroller = FloatingPanelController()
    var charecters : CharacterInfoModel? = nil
    var characterImages : [UIImage] = []
    let searchController = UISearchController(searchResultsController : nil)
    let viewcont = FloatingViewController()
    
    
    
    
    @IBOutlet weak var charectersTableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.loadAllCharacters()
        }
        charectersTableView.rowHeight = 120
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        charectersTableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        let micImage = UIImage(systemName: "mic.fill")
        searchController.searchBar.setImage(micImage, for: .bookmark, state: .normal)
        searchController.searchBar.showsBookmarkButton = true
        charectersTableView.dataSource = self
        charectersTableView.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.charectersTableView.reloadData()
        }
        
        

    }
    
    func loadAllCharacters(){
            
            let url = URL(string: "https://rickandmortyapi.com/api/character")
            
            guard let downloadURL = url else { return }
            
            URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
                guard let data = data, error == nil, urlResponse != nil else{
                    print("something is wrong")
                    
                    return
                }
                
                do{
                    let decoder = JSONDecoder()
                    let characterInfo = try decoder.decode(CharacterInfoModel.self, from: data)
                    self.charecters = characterInfo
                    return
            }
            catch
            {
               print("somethimg is wrong")
            }
                
        }.resume()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        charectersTableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "showDetails", sender: charecters!.results[indexPath.row])
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetails"){
            if let vc = segue.destination as? FloatingViewController {
                if let sender = sender as? CharacterModel{
                    vc.nam = sender.name
                    vc.lal = sender.location.name
                    vc.ori = sender.origin.name
                    vc.gen = sender.gender
                    vc.sta = "\(sender.species)-\(sender.status)"
                    vc.img = sender.image
                    
                    
                }
            }
        }
        
    }
    

}
extension CharacterViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let char = charecters {
            return char.results.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = charectersTableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        let bgColorView = UIView()
        bgColorView.layer.cornerRadius = 10
        bgColorView.backgroundColor = UIColor.darkGray
        cell.selectedBackgroundView = bgColorView
        if let char = charecters {
            cell.CharacterTitle.text = char.results[indexPath.row].name
            cell.characterIndex.text = "\(indexPath.row + 1)"
            let urlString = char.results[indexPath.row].image
            let resourse = ImageResource(downloadURL: URL(string: urlString)!)
            cell.characterImage.kf.setImage(with: resourse)
            
        }
        return cell
    }
}

