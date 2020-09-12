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
      let itemArray = items.results
      let result = itemArray.map { DetailUIModel(item: $0) }
      self.dataToUI = result
    }
  }
}

// MARK: DetailUIModel
struct DetailUIModel {
  let title: String
  let artistName: String
  var image: URL? = nil
}

extension DetailUIModel {
  init(item: Detail) {
    self.title = item.collectionName ?? ""
    if let url = item.artworkUrl100 {
    self.image = URL(string: url)
    }
    self.artistName = item.artistName ?? ""
  }
}
