//
//  DetailModel.swift
//  ITunesSearch
//
//  Created by admin on 12.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation


// MARK: - DetailItems
struct DetailItems: Codable {
  let resultCount: Int
  let results: [Detail]
}

// MARK: - Detail
struct Detail: Codable {
  let wrapperType: WrapperType
  let artistID, collectionID: Int?
  let amgArtistID: Int?
  let artistName: String?
  let collectionName, collectionCensoredName: String?
  let artistViewURL, collectionViewURL: String?
  let artworkUrl60, artworkUrl100: String?
  let collectionPrice: Double?
  let trackCount: Int?
  let copyright: String?
  let country: String?
  let currency: String?
  let releaseDate: String?
  let primaryGenreName: String?
  let kind: String?
  let trackID: Int?
  let trackName, trackCensoredName: String?
  let trackViewURL: String?
  let previewURL: String?
  let artworkUrl30: String?
  let trackPrice: Double?
  let trackExplicitness: String?
  let discCount, discNumber, trackNumber, trackTimeMillis: Int?
  
  enum CodingKeys: String, CodingKey {
    case wrapperType
    case artistID = "artistId"
    case collectionID = "collectionId"
    case amgArtistID = "amgArtistId"
    case artistName, collectionName, collectionCensoredName
    case artistViewURL = "artistViewUrl"
    case collectionViewURL = "collectionViewUrl"
    case artworkUrl60, artworkUrl100, collectionPrice, trackCount, copyright, country, currency, releaseDate, primaryGenreName, kind
    case trackID = "trackId"
    case trackName, trackCensoredName
    case trackViewURL = "trackViewUrl"
    case previewURL = "previewUrl"
    case artworkUrl30, trackPrice, trackExplicitness, discCount, discNumber, trackNumber, trackTimeMillis
  }
}


