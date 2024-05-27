//
//  RestaurantsTableViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit

class RestaurantsTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchNavigationBar: UINavigationItem!
    
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var likeListButton: UIButton!
    
    var dao: RestaurantDAO!
    var sectionDao: SectionDAO!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeStatusBarBgColor(bgColor: UIColor.white)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dao = RestaurantDAO()
        sectionDao = SectionDAO()
        setSearchNavigationBar()
        tableView.setLayoutforRestaurant()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionDao.getSectionList().count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 && dao.getIsLikeResult() {
            return dao.getLikedCount()
        }
        if section == 1 && dao.getIsSearchResult() {
            return dao.getSearchedCount()
        }
        
        return sectionDao.getSection(at: section).rowSize
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let rowIndex = indexPath.row
        var data: Restaurant
        
        if dao.getIsLikeResult() {
            data = dao.getLikedRestaurant(at: rowIndex)
        } else if dao.getIsSearchResult() {
            data = dao.getSearchedRestaurant(at: rowIndex)
        } else {
            data = dao.getRestaurant(at: rowIndex)
        }
        
        var cell = UITableViewCell()
        if section == 0 {
            let identifier = CellIdentifier.SearchRestaurantTableViewCell.describe
            let searchCell = tableView.dequeueReusableCell(withIdentifier:
                                                 identifier,for: indexPath) as! SearchRestaurantTableViewCell
            searchCell.configLayout()
            searchCell.configCell()
            cell = searchCell

        } else if section == 1 {
            let identifier = CellIdentifier.RestaurantTableViewCell.describe
            let restaurantCell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                    for: indexPath) as! RestaurantTableViewCell
            restaurantCell.configCell(data, rowIndex: rowIndex)
            restaurantCell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
            cell = restaurantCell
        }
    
        print("now: \(rowIndex)")
        if dao.getIsLikeResult() && rowIndex == dao.getLikedCount()-1 {
            print("좋아요 레스토랑 마지막: \(dao.getLikedCount())")
            dao.updateIsLikeResult()
            //print("isLikeResult: \(isLikeResult)")
            dao.clearLikedArray()
            return cell
        }
        
        if dao.getIsSearchResult() && rowIndex == dao.getSearchedCount()-1 {
            print("검색된 레스토랑 마지막: \(dao.getSearchedCount())")
            dao.updateIsSearchResult()
            //print("isSearchResult: \()")
            dao.clearSearchedArray()
            return cell
        }
        return cell
    }
    
    func setSearchNavigationBar() {
        navigationController?.setLayoutForRestuarant()
        tabBarController?.setLayoutForRetaurant()
        
        searchTextField.delegate = self
        searchTextField.setLayoutForSearchBar()
        
        likeListButton.setLayoutForLikeList()
        likeListButton.addTarget(self, action: #selector(likeListButtonClicked), for: .touchUpInside)
    }
       
    @objc func likeListButtonClicked(_ sender: UIButton) {
        dao.setLikedArray()
        dao.updateIsLikeResult()
        tableView.reloadData()
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        dao.updateLike(at: sender.tag)
        let indexPaths = [IndexPath(row: sender.tag, section:1)]
        tableView.reloadRows(at:indexPaths, with: .none)
    }
    
    func searchRestaurants(word: String) {
        dao.updateIsSearchResult()
        print("isSearchResult_inputEnter:\(dao.getIsSearchResult())")
        dao.setSearchedArray(word: word)
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ sender: UITextField) -> Bool {
        if sender == searchTextField {
            guard let word = searchTextField.text else {
                return true
            }
            searchTextField.resignFirstResponder()
            searchRestaurants(word: word)
        }
        return true
    }
}
