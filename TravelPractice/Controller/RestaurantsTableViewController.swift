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
    
    var restaurantCRUD: RestaurantCRUD!
    var sectionList: SectionList!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeStatusBarBgColor(bgColor: UIColor.white)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantCRUD = RestaurantCRUD()
        sectionList = SectionList()
        
        setSearchNavigationBar()
        setTableViewAttribue()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.getSectionList().count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 && restaurantCRUD.getIsLikeResult() {
            return restaurantCRUD.getLikedCount()
        }
        if section == 1 && restaurantCRUD.getIsSearchResult() {
            return restaurantCRUD.getSearchedCount()
        }
        
        return sectionList.getSection(at: section).rowSize
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        var cell = UITableViewCell()
    
        if section == 0 {
            let identifier = CellIdentifier.SearchRestaurantTableViewCell.describe
            cell = tableView.dequeueReusableCell(withIdentifier:
                                                 identifier,for: indexPath) as! SearchRestaurantTableViewCell
        } else if section == 1 {
            let identifier = CellIdentifier.RestaurantTableViewCell.describe
            cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                    for: indexPath) as! RestaurantTableViewCell
        }
        
        if section == 1 && tableView.numberOfRows(inSection: section) == 0 {
            return cell
        }
        
        if section == 0 {
            cell = setSerchRestaurantTableViewCell(cell as! SearchRestaurantTableViewCell, row: row)
        } else if section == 1{
            cell = setRestaurantTableViewCells(cell as! RestaurantTableViewCell, section: section, row: row)
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.tintColor = .black
        cell.textLabel?.font = .systemFont(ofSize: 12)
        
        print("now: \(row)")
        if restaurantCRUD.getIsLikeResult() && row == restaurantCRUD.getLikedCount()-1 {
            print("좋아요 레스토랑 마지막: \(restaurantCRUD.getLikedCount())")
            restaurantCRUD.updateIsLikeResult()
            //print("isLikeResult: \(isLikeResult)")
            restaurantCRUD.clearLikedArray()
            return cell
        }
        
        if restaurantCRUD.getIsSearchResult() && row == restaurantCRUD.getSearchedCount()-1 {
            print("검색된 레스토랑 마지막: \(restaurantCRUD.getSearchedCount())")
            restaurantCRUD.updateIsSearchResult()
            //print("isSearchResult: \()")
            restaurantCRUD.clearSearchedArray()
            return cell
        }
        
        return cell
    }
    
    func setTableViewAttribue() {
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 80
        tableView.separatorStyle = .none
        tableView.separatorColor = .gray
        tableView.backgroundColor = .systemGray6
        tableView.sectionHeaderTopPadding = 5
        tableView.sectionHeaderHeight = 5
        tableView.sectionFooterHeight = 5
    }
    
    func changeStatusBarBgColor(bgColor: UIColor?) {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            let statusBarManager = window?.windowScene?.statusBarManager
            
            let statusBarView = UIView(frame: statusBarManager?.statusBarFrame ?? .zero)
            statusBarView.backgroundColor = bgColor
            
            window?.addSubview(statusBarView)
        } else {
            let statusBarView = UIApplication.shared.value(forKey: "statusBar") as? UIView
            statusBarView?.backgroundColor = bgColor
        }
    }
    
    func setSearchNavigationBar() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.backgroundColor = .white
            navigationBar.barTintColor = .white
            navigationBar.tintColor = .black
        }
        if let tabBar = tabBarController?.tabBar {
            tabBar.backgroundColor = .white
            tabBar.barTintColor = .white
        }
        setSearchTextField()
        setLikeListButton()
    }
    
    func setSearchTextField() {
        if !searchTextField.isFirstResponder {
            searchTextField.becomeFirstResponder()
        }
        searchTextField.placeholder = Placeholder.restuarantSearch.get()
        searchTextField.layer.cornerRadius = searchTextField.frame.height * 0.1
        searchTextField.backgroundColor = .systemGray6
        searchTextField.borderStyle = .none
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: searchTextField.frame.height))
        let imageName = "magnifyingglass"
        let image = UIImage(systemName: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 10, y: 7, width: 20, height: 20)
        imageView.tintColor = .gray
        paddingView.addSubview(imageView)
        paddingView.bringSubviewToFront(imageView)

        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = UITextField.ViewMode.always
        searchTextField.delegate = self
    }
    
    func setLikeListButton() {
        likeListButton.tag = 0
        likeListButton.layer.cornerRadius = likeListButton.frame.height * 0.1
        likeListButton.setTitle("", for: .normal)
        likeListButton.tintColor = .systemRed
        likeListButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeListButton.backgroundColor = .white
        likeListButton.addTarget(self, action: #selector(likeListButtonClicked), for: .touchUpInside)
    }
    
    func setSerchRestaurantTableViewCell(_ cell: SearchRestaurantTableViewCell, row: Int) -> SearchRestaurantTableViewCell{
        cell.currentKeywordLabel.text = "최근 검색어"
        cell.currentKeywordLabel.font = .boldSystemFont(ofSize: 15)
        cell.currentKeywordLabel.textAlignment = .left
        
        return cell
    }
    
    func setRestaurantTableViewCells(_ oldCell: RestaurantTableViewCell, section: Int, row index: Int) -> RestaurantTableViewCell {
        
        var cell = oldCell
        var row = Restaurant(image: "", latitude: 0, longitude: 0, name: "", address: "", phoneNumber: "", category: "", price: 0, type: 0, like: false)
        
        print("isSearchResult: \(restaurantCRUD.getIsSearchResult())")
//        print("isLikeResult: \(isLikeResult)")
        if restaurantCRUD.getIsLikeResult() {
            row = restaurantCRUD.getLikedRestaurant(at: index)
        } else if restaurantCRUD.getIsSearchResult() {
            row = restaurantCRUD.getSearchedRestaurant(at: index)
        } else {
            row = restaurantCRUD.getRestaurant(at: index)
        }
        print("beforeSetCell: \(row.name)")
        
        cell = setCellImage(cell, imageURL: row.image)
        cell = setCategoryLabel(cell, category: row.category)
        cell = setRestaurantNameLabel(cell, name: row.name)
        cell = setAddressLabel(cell, adress: row.address)
        cell = setPhoneNumberLabel(cell, phoneNumber: row.phoneNumber)
        cell = setPriceLabel(cell, price: row.price)
        cell = setLikeButton(cell, like: row.like, tag: index)
        
        return cell
    }
    
    func setCellImage(_ cell: RestaurantTableViewCell, imageURL: String) -> RestaurantTableViewCell {
        guard let url = URL(string: imageURL) else {
            return cell
        }
        cell.restaurantImage.contentMode = .scaleAspectFill
        cell.restaurantImage.layer.cornerRadius = cell.restaurantImage.frame.height * 0.05
        cell.restaurantImage.kf.setImage(with: url)
        
        return cell
    }
    
    func setCategoryLabel(_ cell: RestaurantTableViewCell, category: String) -> RestaurantTableViewCell {
        cell.categoryLabel.text = category
        cell.categoryLabel.textAlignment = .left
        cell.categoryLabel.font = .systemFont(ofSize: 10)
        cell.categoryLabel.textColor = .gray
        
        return cell
    }
    
    func setRestaurantNameLabel(_ cell: RestaurantTableViewCell, name: String) -> RestaurantTableViewCell {
        cell.nameLabel.text = name
        cell.nameLabel.textAlignment = .left
        cell.nameLabel.font = .boldSystemFont(ofSize: 15)
        
        return cell
    }
    
    func setAddressLabel(_ cell: RestaurantTableViewCell, adress: String) -> RestaurantTableViewCell {
        cell.addressLabel.text = adress
        cell.addressLabel.textAlignment = .left
        cell.addressLabel.font = .systemFont(ofSize: 10)
        cell.addressLabel.textColor = .gray
        
        return cell
    }
    
    func setPhoneNumberLabel(_ cell: RestaurantTableViewCell, phoneNumber: String) -> RestaurantTableViewCell {
        cell.phoneNumberLabel.text = phoneNumber
        cell.phoneNumberLabel.textAlignment = .left
        cell.phoneNumberLabel.font = .systemFont(ofSize: 10)
        cell.phoneNumberLabel.textColor = .gray
        
        return cell
    }
    
    func setPriceLabel(_ cell: RestaurantTableViewCell, price: Int) -> RestaurantTableViewCell {
        cell.priceLabel.text = "평균 \(price)원" // ,끊어서 표기
        cell.priceLabel.textAlignment = .left
        cell.priceLabel.font = .systemFont(ofSize: 10)
        cell.priceLabel.textColor = .gray
        
        return cell
    }
   
    
    func setLikeButton(_ cell: RestaurantTableViewCell, like: Bool, tag rowIndex: Int) -> RestaurantTableViewCell {
        cell.likeButton.tag = rowIndex
        let image = like ? "heart.fill" : "heart"
        if like {
            cell.likeButton.tintColor = .systemRed
        }
        cell.likeButton.setImage(UIImage(systemName: image), for: .normal)
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
    
        return cell
    }
       
    @objc func likeListButtonClicked(_ sender: UIButton) {
        restaurantCRUD.setLikedArray()
        restaurantCRUD.updateIsLikeResult()
        tableView.reloadData()
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        restaurantCRUD.updateLike(at: sender.tag)
        let indexPaths = [IndexPath(row: sender.tag, section:1)]
        tableView.reloadRows(at:indexPaths, with: .none)
    }
    
    func searchRestaurants(word: String) {
        restaurantCRUD.updateIsSearchResult()
        print("isSearchResult_inputEnter:\(restaurantCRUD.getIsSearchResult())")
        restaurantCRUD.setSearchedArray(word: word)
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
