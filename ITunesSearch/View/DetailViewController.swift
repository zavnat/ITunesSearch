//
//  DetailViewController.swift
//  ITunesSearch
//
//  Created by admin on 12.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import Kingfisher
import MediaPlayer

class DetailViewController: UIViewController {

  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  @IBOutlet weak var commentLabel: UILabel!
  
  let model = DetailViewModel()
  var data: DetailUIModel?
  var id: Int?
  var isSongPlaying = false
  var player: AVPlayer? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    if let detailID = id {
      spinner.startAnimating()
      model.fetchData(with: detailID)
    }
    setupViewModel()
  }
  
  
  private func setupViewModel() {
    model.didUpdateDataToUI = { [weak self] data in
      guard let self = self else { return }
      self.data = data
      print("setupViewModel")
      DispatchQueue.main.async {
        self.spinner.stopAnimating()
        self.tableView.reloadData()
      }
    }
  }
  
}


//MARK: - UITableViewDataSource Methods
extension DetailViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else if section == 1 {
      if let count = data?.songsList.count {
        return count
      } else {
        return 0
      }
    }
    return 0
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "album", for: indexPath) as! DetailAlbumCell
      cell.albumImage.kf.setImage(with: data?.image)
      cell.artistName.text = data?.artistName
      cell.albumName.text = data?.albumName
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "song", for: indexPath) as! DetailSongCell
      cell.cellDelegate = self
      cell.songName.text = data?.songsList[indexPath.row].name
      return cell
    }
  }
}


extension DetailViewController: SongCellDelegate {
  
  func buttonPressed(cell: UITableViewCell) {
   

  }
  
}
