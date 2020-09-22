//
//  DetailSongCell.swift
//  ITunesSearch
//
//  Created by admin on 14.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit

class DetailSongCell: UITableViewCell {
  
  @IBOutlet weak var songName: UILabel!
  @IBOutlet weak var playButton: UIButton!
  
  func configureCell(content: DetailUIModel?, index: IndexPath) {
    self.songName.text = content?.songsList[index.row].name
    
    if let item = content {
      if !item.songsList[index.row].isSongPlaying {
        self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
      } else {
        self.playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
      }
    }
  }
  
}
