//
//  Model.swift
//  ITunesSearch
//
//  Created by admin on 11.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation


// MARK: - Items
struct Items: Codable {
  let resultCount: Int
  let results: [Result]
}


// MARK: - Result
struct Result: Codable {
  let wrapperType: WrapperType
  let artistID, collectionID: Int
  let amgArtistID: Int?
  let artistName, collectionName, collectionCensoredName: String
  let artistViewURL, collectionViewURL: String
  let artworkUrl60, artworkUrl100: String
  let collectionPrice: Double
  let trackCount: Int
  let copyright: String
  let country: String
  let currency: String
  let releaseDate: String
  let primaryGenreName: String
  let contentAdvisoryRating: String?
  
  enum CodingKeys: String, CodingKey {
    case wrapperType
    case artistID = "artistId"
    case collectionID = "collectionId"
    case amgArtistID = "amgArtistId"
    case artistName, collectionName, collectionCensoredName
    case artistViewURL = "artistViewUrl"
    case collectionViewURL = "collectionViewUrl"
    case artworkUrl60, artworkUrl100, collectionPrice, trackCount, copyright, country, currency, releaseDate, primaryGenreName, contentAdvisoryRating
  }
}


enum WrapperType: String, Codable {
  case collection = "collection"
  case track = "track"
}

