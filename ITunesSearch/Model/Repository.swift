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
  

  func request(_ text: String, completion: @escaping (Items) -> ()){
    let parameters: [String : String] = [
      "term" : "jack+johnson",
      "entity" : "album"
    ]


    Alamofire.request(URL, method: .get, parameters: parameters).response { (response) in
      guard let data = response.data else { return }
      let decoder = JSONDecoder()
      do {
        let results = try decoder.decode(Items.self, from: data)
        completion(results)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
