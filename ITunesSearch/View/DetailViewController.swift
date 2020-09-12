//
//  DetailViewController.swift
//  ITunesSearch
//
//  Created by admin on 12.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
  
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var artistLabel: UILabel!
  let model = DetailViewModel()
  var id: Int?
  var data = [DetailUIModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let detailID = id {
      model.fetchData(with: detailID)
    }
    setupViewModel()
  }
  deinit {
    print("deinit")
  }
  
  private func setupViewModel() {
    model.didUpdateDataToUI = { [weak self] data in
      guard let self = self else { return }
      self.data = data
      self.label.text = data[0].title
      self.artistLabel.text = data[0].artistName
      self.image.kf.setImage(with: data[0].image)
    }
  }
  
}
