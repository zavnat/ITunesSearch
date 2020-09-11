//
//  ViewController.swift
//  ITunesSearch
//
//  Created by admin on 11.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var search: UISearchBar!
  
  let model = ViewModel()
  var dataToUI = [UIModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    search.delegate = self
    setupViewModel()
  }
  
  private func setupViewModel() {
    model.didUpdateDataToUI = { [weak self] data in
      guard let self = self else { return }
      self.dataToUI = data
      print(self.dataToUI[0].title)
    }
  }
}

extension ViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let text = searchBar.text {
      print(text)
      model.request(with: text)
    }
    searchBar.resignFirstResponder()
  }
}
