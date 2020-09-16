//
//  Repository.swift
//  ITunesSearch
//
//  Created by admin on 11.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//


import UIKit
import Alamofire


class Repository {
  
  
  //MARK: - Fetching data from Network
  func request(_ text: String, completion: @escaping (Items?, String?) -> ()){
    let URL = "https://itunes.apple.com/search?"
    
    let parameters: [String : String] = [
      "term": text,
      "entity": "album"
    ]
    var comment: String?
    
    if Connectivity.isConnectedToInternet {
      Alamofire.request(URL, method: .get, parameters: parameters).responseJSON { (response) in
        
        if response.result.isSuccess {
          guard let data = response.data else { return }
          
          let decoder = JSONDecoder()
          do {
            let results = try decoder.decode(Items.self, from: data)
            print(results.resultCount)
            if results.results.isEmpty {
              comment = "Ничего не найдено"
            }
            completion(results, comment)
          } catch {
            print("Error fetch data")
          }
          
        }
      }
    } else {
      comment = "Нет подключения к интернету"
      completion(nil, comment)
    }
  }
  
  
  //MARK: - Fetching detail data from Network
  func requestDetail(_ id: Int, completion: @escaping (DetailItems) -> ()){
    let detailURL = "https://itunes.apple.com/lookup?"
    
    let parameters: [String : String] = [
      "entity" : "song",
      "id" : "\(id)"
    ]
    
    
      Alamofire.request(detailURL, method: .get, parameters: parameters).response { (response) in
        guard let data = response.data else { return }
        let decoder = JSONDecoder()
        do {
          let results = try decoder.decode(DetailItems.self, from: data)
          completion(results)
        } catch {
          print("Error fetch data")
      }
    }
  }
  
}


class Connectivity {
  class var isConnectedToInternet: Bool {
    return NetworkReachabilityManager()?.isReachable ?? false
  }
}


extension Repository {
  func searchData(_ text: String, completion: @escaping ([Artist]) -> ()){
    let url = "https://itunes.apple.com/search?"
    
    let parameters: [String : String] = [
      "term": text,
      "entity": "musicArtist",
      "limit": "4"
    ]
   
      Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
        if response.result.isSuccess {
          if response.result.isSuccess {
          guard let data = response.data else { return }
          let decoder = JSONDecoder()
            do {
              let results = try decoder.decode(Search.self, from: data)
              completion(results.results)
            } catch {
              print("Error fetch data")
          }
          }
        }
        }
  }
}


struct Search: Codable {
  let resultCount: Int
  let results: [Artist]
}

// MARK: - Result
struct Artist: Codable {
  let artistName: String
  
}
