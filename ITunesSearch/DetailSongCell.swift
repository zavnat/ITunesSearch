//
//  DetailSongCell.swift
//  ITunesSearch
//
//  Created by admin on 14.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit

//protocol SongCellDelegate {
//  func buttonPressed(cell: UITableViewCell)
//}

class DetailSongCell: UITableViewCell {
//  var cellDelegate: SongCellDelegate?
  @IBOutlet weak var songName: UILabel!
  @IBOutlet weak var playButton: UIButton!
  
  
//  @IBAction func playButtonPressed(_ sender: UIButton) {
//    cellDelegate?.buttonPressed(cell: self)
//    print("playButtonPressed")
//  }
}
