//
//  DetailModel.swift
//  ITunesSearch
//
//  Created by admin on 12.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation

struct DetailItems: Codable {
  let resultCount: Int
  let results: [Detail]
}


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


// MARK: DetailUIModel
struct DetailUIModel {
  let title: String?
  let artistName: String?
  let albumName: String?
  var image: URL? = nil
  var songsList: [Song]
  var musicType: String?
  var date: String?
}


struct Song {
  var name: String
  var song: String
  var isSongPlaying = false
}


extension DetailUIModel {
  init(_ items: DetailItems) {
    let itemArray = items.results
    
    self.title = itemArray[0].collectionName
    self.albumName = itemArray[0].collectionName
    self.artistName = itemArray[0].artistName
    self.musicType = itemArray[0].primaryGenreName
    
    if let url = itemArray[0].artworkUrl100 {
      self.image = URL(string: url)
    }
    
    var songArray = [Song]()
    if !itemArray.isEmpty {
      for song in 1 ..< itemArray.count {
        if let text = itemArray[song].trackName {
          if let song = itemArray[song].previewURL {
            songArray.append(Song(name: text, song: song))
          }
        }
      }
    }
    self.songsList = songArray
    self.date = getDate(from: itemArray[0].releaseDate)
  }
  
  
  func getDate(from string: String?) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    if let stringDate = string {
      if let date = formatter.date(from: stringDate) {
        formatter.dateFormat = "yyyy"
        let result = formatter.string(from: date)
        return result
      }
    }
    return nil
  }
  
}


