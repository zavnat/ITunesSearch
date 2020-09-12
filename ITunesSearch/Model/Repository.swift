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
  let URL = "https://itunes.apple.com/search?"
  let detailURL = "https://itunes.apple.com/lookup?"
  
  
  func request(_ text: String, completion: @escaping (Items) -> ()){
    let parameters: [String : String] = [
      "term" : text,
      "entity" : "album"
    ]
    

    Alamofire.request(URL, method: .get, parameters: parameters).response { (response) in
      guard let data = response.data else { return }
//      print(data)
      let decoder = JSONDecoder()
      do {
        let results = try decoder.decode(Items.self, from: data)
        completion(results)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func requestDetail(_ id: Int, completion: @escaping (DetailItems) -> ()){
    print(id)
    let parameters: [String : String] = [
      "entity" : "song",
      "id" : "\(id)"
    ]


    Alamofire.request(detailURL, method: .get, parameters: parameters).response { (response) in
      guard let data = response.data else { return }
      print(data)
      let decoder = JSONDecoder()
      do {
        let results = try decoder.decode(DetailItems.self, from: data)
        completion(results)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
}
