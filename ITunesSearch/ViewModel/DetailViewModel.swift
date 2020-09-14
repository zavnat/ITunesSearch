//
//  DetailViewModel.swift
//  ITunesSearch
//
//  Created by admin on 12.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation

class DetailViewModel {
  
  let repository = Repository()
  var didUpdateDataToUI: (([DetailUIModel]) -> Void)?
  private(set) var dataToUI: [DetailUIModel]? {
    didSet {
      didUpdateDataToUI?(dataToUI!)
    }
  }
  
  
  func fetchData(with id: Int) {
    repository.requestDetail(id){ [weak self] items in
      guard let self = self else { return }
//      let itemArray = items.results
//      let result = itemArray.map { DetailUIModel(item: $0, count: items.resultCount) }
      let result = DetailUIModel(items)
//      self.dataToUI = result
    }
  }
  
}

// MARK: DetailUIModel
struct DetailUIModel {
  let title: String
  let artistName: String
  var image: URL? = nil
  var songsList: String
}

extension DetailUIModel {
  init(_ items: DetailItems) {
    let itemArray = items.results
    self.title = itemArray[0].collectionName ?? ""
    if let url = itemArray[0].artworkUrl100 {
    self.image = URL(string: url)
    }
    self.artistName = itemArray[0].artistName ?? ""
    var string = ""
    for song in 1...itemArray.count {
      string += itemArray[song].artistName!
    }
    self.songsList = string
  }
}
