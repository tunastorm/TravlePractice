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
    
//    var dao: RestaurantDAO!
//    var sectionDao: SectionDAO!
    
    var list = RestaurantList().restaurantArray
    var searchIdxList: [Int] = []
    var searchList: [Restaurant] = []
    var likeList: [Restaurant] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        dao = RestaurantDAO()
//        sectionDao = SectionDAO()
        print("seacrhList: \(searchList)")
        setSearchNavigationBar()
        tableView.setLayoutforRestaurant()
        changeStatusBarBgColor(bgColor: UIColor.white)
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
//        return sectionDao.getSectionList().count
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if section == 1 && dao.getIsLikeResult() {
//            return dao.getLikedCount()
//        }
//        if section == 1 && dao.getIsSearchResult() {
//            return dao.getSearchedCount()
//        }
//        
//        return sectionDao.getSection(at: section).rowSize
        if searchIdxList.count > 0{
            for idx in searchIdxList {
                searchList.append(list[idx])
            }
        }
        
        var rowSize = 0
        
        if section == 0 {
            rowSize = 1
        } else if section == 1 {
            rowSize = searchList.count
        }
        
        return rowSize
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        if section == 0 {
            return 80
        } else {
            return 140
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let rowIndex = indexPath.row
        
        print("section: \(section)")
        print("rowIndex: \(rowIndex)")
        
        var cell = UITableViewCell()
        
        if section == 1 && !searchList.isEmpty {
            let data = searchList[rowIndex]
            
            let identifier = CellIdentifier.RestaurantTableViewCell.describe
            let restaurantCell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                    for: indexPath) as! RestaurantTableViewCell
            restaurantCell.configCell(data, rowIndex: rowIndex)
            restaurantCell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
            cell = restaurantCell
            
//            if rowIndex == searchList.count-1 {
//                searchList.removeAll()
//            }
            
        } else if section == 0 {
            let identifier = CellIdentifier.SearchRestaurantTableViewCell.describe
            let searchCell = tableView.dequeueReusableCell(withIdentifier:
                                                 identifier,for: indexPath) as! SearchRestaurantTableViewCell
            searchCell.configCell()
            cell = searchCell
        }
        
        
//        if dao.getIsLikeResult() {
//            data = dao.getLikedRestaurant(at: rowIndex)
//        } else if dao.getIsSearchResult() {
//            data = dao.getSearchedRestaurant(at: rowIndex)
//        } else {
//            data = dao.getRestaurant(at: rowIndex)
//        }
        

//        print("now: \(rowIndex)")
//        if dao.getIsLikeResult() && rowIndex == dao.getLikedCount()-1 {
//            print("좋아요 레스토랑 마지막: \(dao.getLikedCount())")
//            dao.updateIsLikeResult()
//            //print("isLikeResult: \(isLikeResult)")
//            dao.clearLikedArray()
//            return cell
//        }
//        
//        if dao.getIsSearchResult() && rowIndex == dao.getSearchedCount()-1 {
//            print("검색된 레스토랑 마지막: \(dao.getSearchedCount())")
//            dao.updateIsSearchResult()
//            //print("isSearchResult: \()")
//            dao.clearSearchedArray()
//            return cell
//        }
        
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
    
    func searchRestaurants(word: String) {
        searchList.removeAll()
        searchIdxList.removeAll()
        
        for restaurant in list {
            if restaurant.category.contains(word) {
                searchIdxList.append(restaurant.idx)
                continue
            }
            if restaurant.name.contains(word) {
                searchIdxList.append(restaurant.idx)
                continue
            }
            if restaurant.address.contains(word) {
                searchIdxList.append(restaurant.idx)
                continue
            }
            if restaurant.phoneNumber.contains(word) {
                searchIdxList.append(restaurant.idx)
                continue
            }
            if String(restaurant.price).contains(word) {
                searchIdxList.append(restaurant.idx)
                continue
            }
        }
        print("searchIdxList: \(searchIdxList)")
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
    
    @objc func likeButtonClicked(_ sender: UIButton) {
//        dao.updateLike(at: sender.tag)
        
        print("좋아요 누른 버튼 row: \(sender.tag)")
        
        let idx = searchList[sender.tag].idx
        
        list[idx].like.toggle()
    
        let indexPaths = [IndexPath(row: sender.tag, section:1)]
        tableView.reloadRows(at:indexPaths, with: .none)
    }
    
    @objc func likeListButtonClicked(_ sender: UIButton) {
        searchList.removeAll()
        searchIdxList.removeAll()
//        dao.setLikedArray()
//        dao.updateIsLikeResult()
        
        for restaurant in list {
            if restaurant.like {
                searchIdxList.append(restaurant.idx)
                continue
            }
        }
        tableView.reloadData()
    }
}
