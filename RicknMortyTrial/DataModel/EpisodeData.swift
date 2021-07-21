//
//  EpisodeDeatil.swift
//  RicknMortyTrial
//
//  Created by Vaibhav Shah on 13/07/21.
//

import Foundation

struct EpisodeInfoModel: Codable {
    let results: [EpisodeModel]
}

/*
 Episode struct for decoding episode json response.
 Properties
 - id: The id of the episode.
 - name: The name of the episode.
 - airDate: The air date of the episode.
 - episode: The code of the episode.
 - characters: List of characters who have been seen in the episode.
 - url: Link to the episode's own endpoint.
 - created: Time at which the episode was created in the database.
 */

public struct EpisodeModel: Codable{
    public let id: Int
    public let name: String
    public let airDate: String
    public let episode: String
    public let characters: [String]
    public let url: String
    public let created: String
    
    enum CodingKeys: String, CodingKey {
            case id, name, episode, characters, url, created
            case airDate = "air_date"
        }
}
