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
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var search: UISearchBar!
  @IBOutlet weak var commentLabel: UILabel!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  let model = ViewModel()
  var dataToUI = [UIModel]()
  var searchData = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
    collectionView.delegate = self
    search.delegate = self
    setupViewModel()
    commentLabel.text = "Введите исполнителя для поиска"
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
    
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  @objc func dismissKeyboard() {
      view.endEditing(true)
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
    model.didUpdateSearchArrayToUI = { [weak self] data in
    guard let self = self else { return }
      self.searchData = data
      
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
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
    tableView.isHidden = true
    searchBar.resignFirstResponder()
  }
  
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    tableView.isHidden = false
    if searchBar.text?.count == 0 {
      dataToUI = []
      self.searchData = []
      commentLabel.isHidden = false
      commentLabel.text = "Введите исполнителя для поиска"
      DispatchQueue.main.async {
        searchBar.resignFirstResponder()
        self.tableView.isHidden = true
        self.tableView.reloadData()
        self.collectionView.reloadData()
      }
    } else if searchBar.text!.count >= 3 {
      model.search(searchBar.text!)
    }
  }
  
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
    cell.label.text = searchData[indexPath.row]
    return cell
  }
  
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("did select")
    let text = searchData[indexPath.row]
    tableView.isHidden = true
    print(text)
    model.request(with: text)
  }
  
}
