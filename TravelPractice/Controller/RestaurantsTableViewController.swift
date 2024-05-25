//
//  RestaurantsTableViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit

class RestaurantsTableViewController: UITableViewController {
    
    var retaurantCRUD = RestaurantCRUD()
    
    var sectionList = SectionList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "맛집 리스트"
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.separatorColor = .gray
        tableView.backgroundColor = .systemGray6
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
            let identifier = CellIdentifiers.SearchRestaurantTableViewCell.describe
            cell = tableView.dequeueReusableCell(withIdentifier:
                                                 identifier,for: indexPath) as! SearchRestaurantTableViewCell
            cell = setSerchViewCell(cell as! SearchRestaurantTableViewCell, row: row)
        } else if section == 1 {
            let identifier = CellIdentifiers.RestaurantTableViewCell.describe
            cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                    for: indexPath) as! RestaurantTableViewCell
            cell = setShoppingTableViewCells(cell as! RestaurantTableViewCell, section: section, row: row)
        }
        
        cell.selectionStyle = .default
        cell.backgroundColor = .white
        cell.tintColor = .black
        cell.textLabel?.font = .systemFont(ofSize: 12)
        
        return cell
    }
    
    func setSerchViewCell(_ cell: SearchRestaurantTableViewCell, row: Int) -> SearchRestaurantTableViewCell{
        cell.searchTextField.placeholder = searchBarTitles[0]
        cell.searchTextField.backgroundColor = .systemGray6
        cell.searchTextField.borderStyle = .none
//        
//        cell.searchButton.tag = row
//        cell.searchButton.layer.cornerRadius = cell.searchButton.frame.height * 0.1
//        cell.searchButton.setTitle(searchBarTitles[1], for: .normal)
//        cell.searchButton.backgroundColor = .systemGray5
//        cell.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
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
    
//    @objc func searchButtonClicked(_ sender: UIButton) {
//        
//        let indexPath = IndexPath(row: sender.tag, section:0)
//        
//        let cell = tableView.cellForRow(at: indexPath) as! SearchTableViewCell
//
//        
//        
//            tableView.reloadData()
//        }
//    }
    
//    // Event: Push Up Inside
//    @objc func likekButtonClicked(_ sender: UIButton) {
//        restaurantCRUD.updateLike(at: sender.tag)
//        let indexPaths = [IndexPath(row: sender.tag, section:1)]
//        tableView.reloadRows(at:indexPaths, with: .none)
//    }

}
