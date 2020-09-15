//
//  ViewController.swift
//  ITunesSearch
//
//  Created by admin on 11.09.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UICollectionViewDelegate {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var search: UISearchBar!
  @IBOutlet weak var commentLabel: UILabel!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  let model = ViewModel()
  var dataToUI = [UIModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
    collectionView.delegate = self
    search.delegate = self
    setupViewModel()
    commentLabel.text = "Введите исполнителя для поиска"
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  
  private func setupViewModel() {
    model.didUpdateDataToUI = { [weak self] data in
      guard let self = self else { return }
      self.dataToUI = data
      
      DispatchQueue.main.async {
        self.spinner.stopAnimating()
        self.collectionView.reloadData()
      }
      self.checkComment()
    }
  }
  
  
  private func checkComment() {
    if self.model.comment != nil {
      self.commentLabel.isHidden = false
      self.commentLabel.text = self.model.comment
    } else {
      self.commentLabel.isHidden = true
    }
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToDetail"{
      let destinationVC = segue.destination as? DetailViewController
      if let indexPath = collectionView.indexPathsForSelectedItems?.first {
        destinationVC?.id = dataToUI[indexPath.row].id
      }
    }
  }
}


//MARK: - UICollectionViewDataSource Method
extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataToUI.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionCell
    cell.cellLabel.text = dataToUI[indexPath.row].title
    cell.cellImage.kf.setImage(with: dataToUI[indexPath.row].image)
    return cell
  }
}


//MARK: - CollectionViewDelegateFlowLayout Methods
extension ViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = collectionView.frame.height / 3
    let width  = collectionView.frame.width / 2 - 10
    return CGSize(width: width, height: height)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 2.5
  }
    

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20.0
  }
}


//MARK: UISearchBarDelegate Methods
extension ViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let text = searchBar.text {
      model.request(with: text)
      spinner.startAnimating()
    }
    checkComment()
    searchBar.resignFirstResponder()
  }
  
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text?.count == 0 {
      dataToUI = []
      commentLabel.isHidden = false
      commentLabel.text = "Введите исполнителя для поиска"
      DispatchQueue.main.async {
        searchBar.resignFirstResponder()
        self.collectionView.reloadData()
      }
    }
  }
  
}
