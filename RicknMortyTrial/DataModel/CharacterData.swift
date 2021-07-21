//
//  CharacterData.swift
//  RicknMortyTrial
//
//  Created by Vaibhav Shah on 11/07/21.
//

import UIKit




struct CharacterInfoModel: Codable {
    let results: [CharacterModel]
}

/*
 Character struct for decoding character json response.
  Properties
 - id: The id of the character.
 - name: The name of the character.
 - status: The status of the character ('Alive', 'Dead' or 'unknown').
 - species: The species of the character.
 - type: The type or subspecies of the character.
 - gender: The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
 - origin: Name and link to the character's origin location.
 - location: Name and link to the character's last known location endpoint.
 - image: Link to the character's image.
 - episodes: List of episodes in which this character appeared.
 - url : Link to the character's own URL endpoint.
 - created: Time at which the character was created in the database.
 */
public struct CharacterModel: Codable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: CharacterOriginModel
    public let location: CharacterLocationModel
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
}

/*
 Origin struct for decoding character json origin response.
 Properties
 - name: The name of the origin.
 - url: Link to the origin's own URL endpoint.
 */
public struct CharacterOriginModel: Codable {
    public let name: String
    public let url: String
}

/*
 Location struct for decoding character location json response.
  Properties
 - name: The name of the location.
 - url: Link to the location's own URL endpoint.
 */
public struct CharacterLocationModel: Codable {
    public let name: String
    public let url: String
}

/*
 To filter by status
 */
public enum Status: String {
    case alive = "alive"
    case dead = "dead"
    case unknown = "unknown"
    case none = ""
}

/*
  To filter by gender
 */
public enum Gender: String {
    case female = "female"
    case male = "male"
    case genderless = "genderless"
    case unknown = "unknown"
    case none = ""
}




