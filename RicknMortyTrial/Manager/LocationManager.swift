//
//  LocationManager.swift
//  RicknMortyTrial
//
//  Created by Vaibhav Shah on 13/07/21.
//

import Foundation


//Function to download Json data for Location

func downloadLocationJSON(){
    
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
            print(locationInfo.results.count)   //Tried if the following is working or Not
            
        }catch{
            print("something is wrong")
        }
    }.resume()
}

