//
//  LocaationData.swift
//  RicknMortyTrial
//
//  Created by Vaibhav Shah on 13/07/21.
//

import Foundation

struct LocationInfoModel: Codable {
    let results: [LocationModel]
}

/*
 Episode struct for decoding episode json response.
  Properties
 - id: The id of the location.
 - name: The name of the location.
 - type: The type of the location.
 - dimension: The dimension in which the location is located.
 - residents: List of location who have been last seen in the location.
 - url: Link to location's own endpoint.
 - created: Time at which the location was created in the database.
 */
public struct LocationModel: Codable  {
    public let id: Int
    public let name: String
    public let type: String
    public let dimension: String
    public let residents: [String]
    public let url: String
    public let created: String
}
