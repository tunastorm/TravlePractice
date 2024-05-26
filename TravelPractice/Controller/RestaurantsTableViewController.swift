//
//  RestaurantsTableViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit

class RestaurantsTableViewController: UITableViewController {
    
    
    @IBOutlet weak var searchNavigationBar: UINavigationItem!
    
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var likeListButton: UIButton!
    
    var retaurantCRUD = RestaurantCRUD()
    var sectionList = SectionList()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeStatusBarBgColor(bgColor: UIColor.white)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.backgroundColor = .white
            navigationBar.barTintColor = .white
            navigationBar.tintColor = .black
        }
        
   
        
    
        if let tabBar = tabBarController?.tabBar {
            tabBar.backgroundColor = .white
            tabBar.barTintColor = .white
        }
        
        // tableView.rowHeight = 70
        tableView.separatorStyle = .none
        tableView.separatorColor = .gray
        tableView.backgroundColor = .systemGray6
        tableView.sectionHeaderTopPadding = 5
        tableView.sectionHeaderHeight = 5
        tableView.sectionFooterHeight = 5
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.getSectionList().count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            cell = setSerchViewCell(cell as! SearchRestaurantTableViewCell, row: row)
        } else if section == 1 {
            let identifier = CellIdentifier.RestaurantTableViewCell.describe
            cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                    for: indexPath) as! RestaurantTableViewCell
            cell = setShoppingTableViewCells(cell as! RestaurantTableViewCell, section: section, row: row)
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.tintColor = .black
        cell.textLabel?.font = .systemFont(ofSize: 12)
        
        return cell
    }
    
    
    func changeStatusBarBgColor(bgColor: UIColor?) {
        /* 출처
         * https://growup-lee.tistory.com/entry/Swift-Status-Bar-Background-Color-%EB%B3%80%EA%B2%BD
         */
   
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
    
    
    func setSearchBar() {
        searchTextField.placeholder = Placeholder.restuarantSearch.get()
        searchTextField.backgroundColor = .systemGray6
        searchTextField.borderStyle = .none
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchTextField.frame.height))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = UITextField.ViewMode.always
        searchTextField.layer.cornerRadius = searchTextField.frame.height * 0.1

        likeListButton.tag = 0
        likeListButton.layer.cornerRadius = likeListButton.frame.height * 0.1
        likeListButton.setTitle("", for: .normal)
        likeListButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeListButton.backgroundColor = .white
        likeListButton.addTarget(self, action: #selector(likeListButtonClicked), for: .touchUpInside)
    }
    
    
    func setSerchViewCell(_ cell: SearchRestaurantTableViewCell, row: Int) -> SearchRestaurantTableViewCell{
        
        return cell
    }
    
    func setShoppingTableViewCells(_ cell : RestaurantTableViewCell, section: Int, row index: Int) -> RestaurantTableViewCell{
        
          
        
//        let row = restaurantCRUD.getTodo(at: index)
//        
//        cell.todoLabel.text = row.action
//        let doneName = row.isDone ? "checkmark.square.fill":"checkmark.square"
//        let bookmarkName = row.bookmark ? "star.fill" : "star"
//        
//        let doneImage = UIImage(systemName: doneName)
//        let bookmarkImage = UIImage(systemName: bookmarkName)
//        
//        cell.isDoneButton.setTitle("", for: .normal)
//        cell.isDoneButton.setImage(doneImage, for: .normal)
//        cell.isDoneButton.tag = index
//        cell.isDoneButton.addTarget(self, action: #selector(isDoneButtonClicked), for: .touchUpInside)
//        
//        cell.bookmarkButton.setTitle("", for: .normal)
//        cell.bookmarkButton.tag = index
//        cell.bookmarkButton.setImage(bookmarkImage, for: .normal)
//        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    
    
       
    @objc func likeListButtonClicked(_ sender: UIButton) {
        
//        let indexPath = IndexPath(row: sender.tag, section:0)
        
//        let cell = tableView.cellForRow(at: indexPath) as! SearchRestaurantTableViewCell
        
        let searchText = searchTextField.text
        
        
        tableView.reloadData()
    }
    
    
//    }
    
//    // Event: Push Up Inside
//    @objc func likekButtonClicked(_ sender: UIButton) {
//        restaurantCRUD.updateLike(at: sender.tag)
//        let indexPaths = [IndexPath(row: sender.tag, section:1)]
//        tableView.reloadRows(at:indexPaths, with: .none)
//    }

}
