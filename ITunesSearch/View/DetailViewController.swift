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
  var playingMusic: IndexPath?
  var player = AVPlayer()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    if let detailID = id {
      spinner.startAnimating()
      model.fetchData(with: detailID)
    }
    setupViewModel()
  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
    player.pause()
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
      cell.configureCell(content: data)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "song", for: indexPath) as! DetailSongCell
      cell.configureCell(content: data, index: indexPath)
      return cell
    }
  }
}


//MARK: - TableViewDelagate Methods
extension DetailViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    music(for: indexPath)
  }
  
  
  func music(for indexPath: IndexPath) {
    guard let item = data?.songsList[indexPath.row].song else {return}
    
    if  indexPath == playingMusic {
      stopSound()
      data?.songsList[indexPath.row].isSongPlaying = false
      
      DispatchQueue.main.async {
        self.tableView.reloadRows(at: [indexPath], with: .none)
      }
      playingMusic = nil
      
    } else if indexPath != playingMusic && playingMusic != nil {
      stopSound()
      if let music = playingMusic {
        data?.songsList[music.row].isSongPlaying = false
        data?.songsList[indexPath.row].isSongPlaying = true
        playSound(item, indexPath)
        playingMusic = indexPath
        
        DispatchQueue.main.async{
          self.tableView.reloadData()
        }
      } else {
        print("not music")
      }
    } else {
      playSound(item, indexPath)
      data?.songsList[indexPath.row].isSongPlaying = true
      playingMusic = indexPath
      
      DispatchQueue.main.async{
        self.tableView.reloadRows(at: [indexPath], with: .none)
        self.tableView.reloadData()
      }
    }
  }
  
  
  func playSound(_ string: String, _ indexPath: IndexPath){
    player.pause()
    let url  = URL(string: string)
    let playerItem: AVPlayerItem = AVPlayerItem(url: url!)
    player = AVPlayer(playerItem: playerItem)
    NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    player.play()
  }

  
  func stopSound() {
    player.pause()
  }
  
  
  @objc func playerDidFinishPlaying(sender: Notification) {
    if let index = playingMusic {
      data?.songsList[index.row].isSongPlaying = false
      DispatchQueue.main.async{
//        self.tableView.reloadData()
        self.tableView.reloadRows(at: [index], with: .none)
      }
      playingMusic = nil
      NotificationCenter.default.removeObserver(self)
    }
  }
  
}
