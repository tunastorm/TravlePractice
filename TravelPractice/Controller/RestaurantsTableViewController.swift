//
//  RestaurantsTableViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit

class RestaurantsTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchNavigationBar: UINavigationItem!
        
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var likeListButton: UIButton!
    
    
//    var dao: RestaurantDAO!
//    var sectionDao: SectionDAO!
    
    // 1. 수평스크롤 뷰 버튼들에 검색 및 삭제 이벤트 등록
    // 2. 최근 검색어가 없을 때는 최근 검색어 셀 출력 안 되게 분기처리
    // 3. UserDefaultsManager 사용하여 상태 저장
    // 4. 4개 row 출력후 1개 row는 광고로 출력하기
    
    var list = RestaurantList().restaurantArray
    var searchedWords: [String] = []
    var searchIdxList: [Int] = []
    var searchList: [Restaurant] = []
    var likeList: [Restaurant] = []
    var sectionSize = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("seacrhList: \(searchList)")
        setSearchNavigationBar()
        tableView.setLayoutforRestaurant()
        changeStatusBarBgColor(bgColor: UIColor.white)
        
        NotificationCenter.default.addObserver(self, selector: #selector(searchButtonTapped(notification:)), name: .SearchFieldText, object: nil)
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searchedWords.count > 0 {
            sectionSize = 2
        }
        return sectionSize
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowSize = 0
        
        // 최근 검색어가 없고, 검색결과가 없을 때 행 개수
        if sectionSize == 1 && searchList.count == 0 {
            rowSize = 1
        // 최근 검색어 셀에 표시하는 셀의 행 개수
        } else if sectionSize == 2 && section == 0 {
            rowSize = 1
        // 최근 검색어가 있고, 검색결과 표시하는 셀의 행 개수
        } else if sectionSize == 2 && section == 1 {
            if searchIdxList.count > 0 {
                for idx in searchIdxList {
                    searchList.append(list[idx])
                }
            }
            rowSize = searchList.count
        }
        print("rowSize: \(rowSize)")
        return rowSize
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let section = indexPath.section
//        
//        if section == 0 {
//            return 80
//        } else {
//            return 140
//        }
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let rowIndex = indexPath.row
        
        print("section: \(section)")
        print("rowIndex: \(rowIndex)")
        
        var cell = UITableViewCell()

        if (sectionSize == 1 && searchList.count > 0) ||
           (sectionSize == 2 && section == 1 && searchList.count > 0) {
            let data = searchList[rowIndex]
            
            let identifier = RestaurantTableViewCell.identifier
            print(identifier)
            let restaurantCell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                    for: indexPath) as! RestaurantTableViewCell
            restaurantCell.configCell(data, rowIndex: rowIndex)
            restaurantCell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
            cell = restaurantCell
            
        } else if sectionSize == 2 && section == 0 {
            let identifier = SearchRestaurantTableViewCell.identifier
            print(identifier)
            let searchCell = tableView.dequeueReusableCell(withIdentifier:
                                                 identifier,for: indexPath) as! SearchRestaurantTableViewCell
            guard let currentWord = searchedWords.last else {
                return searchCell
            }
            searchCell.configCell(currentWord)
            cell = searchCell
        }
        
        cell.selectionStyle = .none
        
      return cell
    }
    
    @objc func searchButtonTapped(notification: Notification) {
        if let searchText = notification.object as? String {
            print(searchText)
            searchRestaurants(word: searchText)
        }
    }
    
    func setSearchNavigationBar() {
        navigationController?.setLayoutForRestuarant()
        tabBarController?.setLayoutForRetaurant()
        
        searchTextField.delegate = self
        searchTextField.setLayoutForSearchBar()
        
        likeListButton.setLayoutForLikeList()
        likeListButton.addTarget(self, action: #selector(likeListButtonClicked), for: .touchUpInside)
        
        let mapImage = SystemImage().map
        let leftButton = UIBarButtonItem(image: mapImage, style: .plain, target: self, action: #selector(pushToRestaurantMap))
        navigationItem.leftBarButtonItem = leftButton
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
        if searchIdxList.count > 0 {
            searchedWords.append((word))
            print("searchedWoreds: \(searchedWords)")
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
    
    @objc func searchedWordClicked(_ sender: UIButton) {
        
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
//        dao.updateLike(at: sender.tag)
        
        print("좋아요 누른 버튼 row: \(sender.tag)")
        print("searchIdxList: \(searchIdxList)")
        print("searchList: \(searchList)")
        
        let idx = searchList[sender.tag].idx
        
        list[idx].like.toggle()
        
        searchList.removeAll()
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
    
    @objc func pushToRestaurantMap() {
        let sb = UIStoryboard(name: "RestaurantMap", bundle: nil)
        let identifier = RestaurantMapViewController.identifier
        let vc = sb.instantiateViewController(withIdentifier: identifier) as! RestaurantMapViewController
        vc.allData = list
        navigationController?.pushViewController(vc, animated: true)
    }
}
