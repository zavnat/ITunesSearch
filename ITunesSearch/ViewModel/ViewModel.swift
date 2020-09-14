//
//  ViewModel.swift
//  ITunesSearch
//
//  Created by admin on 11.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation

class ViewModel {
  
  let repository = Repository()
  var didUpdateDataToUI: (([UIModel]) -> Void)?
  private(set) var dataToUI: [UIModel]? {
    didSet {
      didUpdateDataToUI?(dataToUI!)
    }
  }
  
  var comment: String?
  
  func request(with text: String) {
    repository.request(text){ [weak self] (items, text) in
      guard let self = self else { return }
      if let resultData = items {
        self.comment = text
        let itemArray = resultData.results
        var result = itemArray.map { UIModel(item: $0) }
        result.sort { $0.title < $1.title }
        self.dataToUI = result
      } else {
        self.comment = text
      }
    }
  }
}

// MARK: UIModel
struct UIModel {
  let id: Int
  let title: String
  let image: URL?
}

extension UIModel {
  init(item: Result) {
    self.id = item.collectionID
    self.title = item.collectionName
    self.image = URL(string: item.artworkUrl100)
  }
}

