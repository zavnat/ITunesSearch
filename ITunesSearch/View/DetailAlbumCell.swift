//
//  DetailAlbumCell.swift
//  ITunesSearch
//
//  Created by admin on 14.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit

class DetailAlbumCell: UITableViewCell {
  
  @IBOutlet weak var albumName: UILabel!
  @IBOutlet weak var artistName: UILabel!
  @IBOutlet weak var albumImage: UIImageView!
  @IBOutlet weak var musicType: UILabel!
  @IBOutlet weak var date: UILabel!
  
  func configureCell(content: DetailUIModel?) {
    self.albumName.text = content?.albumName
    self.artistName.text = content?.artistName
    self.albumImage.kf.setImage(with: content?.image)
    self.musicType.text = content?.musicType
    self.date.text = content?.date
  }
}
