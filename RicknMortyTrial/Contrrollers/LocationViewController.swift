//
//  LocationViewController.swift
//  RicknMortyTrial
//
//  Created by Henit Work on 21/07/21.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var locationTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var locations : [LocationModel] = []
    var stations : [LocationModel] = []
    var dimensions : [LocationModel] = []
    var planets : [LocationModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        let micImage = UIImage(systemName: "mic.fill")
        searchController.searchBar.setImage(micImage, for: .bookmark, state: .normal)
        searchController.searchBar.showsBookmarkButton = true
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .normal)
        LoadLocations()
        
        locationTableView.register(UINib(nibName: "LocationsTableViewCell", bundle: nil), forCellReuseIdentifier: "locationCell")
        locationTableView.rowHeight = 100
        locationTableView.dataSource = self
        locationTableView.delegate = self
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.locationTableView.reloadData()
        }
        

        // Do any additional setup after loading the view.
    }
    

    func LoadLocations(){
        
        let url = URL(string: "https://rickandmortyapi.com/api/location")
        guard let downloadURL = url else { return }
        
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else{
                print("something is wrong")
                return
            }

            do{
                let decoder = JSONDecoder()
                let locationInfo = try decoder.decode(LocationInfoModel.self, from: data)
                self.locations = locationInfo.results
            
                self.filterLocations()
             
                
            }catch{
                print("something is wrong")
            }
        }.resume()
    }
    
    func filterLocations(){
        
        for location in locations {
            if location.type == "Space station"{
                stations.append(location)
            }
            else if location.type == "Planet"{
                planets.append(location)
            }
            else {
                dimensions.append(location)
            }
        }
        
    }
    
    
    @IBAction func segmentorDidUpdate(_ sender: UISegmentedControl) {
        locationTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationInfo" {
            if let vc = segue.destination as? ShowLocationViewController{
                if let sender = sender as? LocationModel {
                    vc.locationtitle = sender.name
                    vc.subtitle = sender.type
                    vc.residentURLs = sender.residents
                    
                }
            }
        }
    }
}

extension LocationViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationTableView.deselectRow(at: indexPath, animated: true)
        switch segmentControl.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "locationInfo", sender: stations[indexPath.row])
        case 1:
            performSegue(withIdentifier: "locationInfo", sender: dimensions[indexPath.row])
        case 2:
            performSegue(withIdentifier: "locationInfo", sender: planets[indexPath.row])
        default:
            print("Problem here!")
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return stations.count
        case 1:
            return dimensions.count
        case 2:
            return planets.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = locationTableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationsTableViewCell
        var content : [LocationModel] = []
        switch segmentControl.selectedSegmentIndex {
        case 0:
            content = stations
        case 1:
            content = dimensions
        case 2:
            content = planets
        default:
            content = []
        }
        
        cell.locationIndex.text = "\(indexPath.row + 1)"
        cell.locationTitle.text = content[indexPath.row].name
        
        return cell
    }
    
    
}
