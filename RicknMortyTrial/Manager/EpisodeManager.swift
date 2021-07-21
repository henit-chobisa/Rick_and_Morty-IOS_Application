    //
    //  EpisodeManager.swift
    //  RicknMortyTrial
    //
    //  Created by Vaibhav Shah on 13/07/21.
    //

    import Foundation

    //Function to download Json data for Episode
        
        func downloadEpisodeJSON(){
            
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
                  
                    for result in episodeInfo.results {
                        print(result.episode)
                    }
                    //Tried if the following is working or Not
                    
                }catch{
                   print("something is wrong")
                }
            }.resume()
        }

