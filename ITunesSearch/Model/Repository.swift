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
      comment = "no internet"
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
