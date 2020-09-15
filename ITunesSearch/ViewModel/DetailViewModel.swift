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
  var didUpdateDataToUI: ((DetailUIModel) -> Void)?
  private(set) var dataToUI: DetailUIModel? {
    didSet {
      if dataToUI != nil {
      didUpdateDataToUI?(dataToUI!)
      }
    }
  }
  
  
  func fetchData(with id: Int) {
    repository.requestDetail(id){ [weak self] (items) in
      guard let self = self else { return }
        let result = DetailUIModel(items)
        self.dataToUI = result
    }
  }
  
}

