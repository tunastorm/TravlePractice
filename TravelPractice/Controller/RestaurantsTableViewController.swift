//
//  RestaurantsTableViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit

class RestaurantsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "맛집 리스트"
        tableView.rowHeight = 60
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
        tableView.backgroundColor = .white
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return restaurantSectionList.getSectionList().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionList.getSection(at: section).rowSize
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
    
        var cell = UITableViewCell()
        if section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell"
                                                 ,for: indexPath) as! SearchTableViewCell
            print("[loadCell]")
            print(cell)
            print("loadIndexPath: \(indexPath)")
            cell = setSerchViewCell(cell as! SearchTableViewCell, row: row)
        } else if section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell",
                                                    for: indexPath) as! ShoppingTableViewCell
            cell = setShoppingTableViewCells(cell as! ShoppingTableViewCell, section: section, row: row)
        }
        
        cell.selectionStyle = .default
        cell.backgroundColor = .systemGray6
        cell.tintColor = .black
        cell.textLabel?.font = .systemFont(ofSize: 12)
        
        return cell
    }
    
    func setSerchViewCell(_ cell: SearchTableViewCell, row: Int) -> SearchTableViewCell{
        cell.searchTextField.placeholder = searchBarTitles[0]
        cell.searchTextField.backgroundColor = .clear
        cell.searchTextField.borderStyle = .none
        
        cell.searchButton.tag = row
        cell.searchButton.layer.cornerRadius = cell.searchButton.frame.height * 0.1
        cell.searchButton.setTitle(searchBarTitles[1], for: .normal)
        cell.searchButton.backgroundColor = .systemGray5
        cell.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func setShoppingTableViewCells(_ cell : ShoppingTableViewCell, section: Int, row index: Int) -> ShoppingTableViewCell{
        let row = todoList.getTodo(at: index)
        
        cell.todoLabel.text = row.action
        let doneName = row.isDone ? "checkmark.square.fill":"checkmark.square"
        let bookmarkName = row.bookmark ? "star.fill" : "star"
        
        let doneImage = UIImage(systemName: doneName)
        let bookmarkImage = UIImage(systemName: bookmarkName)
        
        cell.isDoneButton.setTitle("", for: .normal)
        cell.isDoneButton.setImage(doneImage, for: .normal)
        cell.isDoneButton.tag = index
        cell.isDoneButton.addTarget(self, action: #selector(isDoneButtonClicked), for: .touchUpInside)
        
        cell.bookmarkButton.setTitle("", for: .normal)
        cell.bookmarkButton.tag = index
        cell.bookmarkButton.setImage(bookmarkImage, for: .normal)
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func searchButtonClicked(_ sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section:0)
        
        let cell = tableView.cellForRow(at: indexPath) as! SearchTableViewCell
    
        if let action = cell.searchTextField.text, !action.isEmpty {
            todoList.append(action: action, isDone: false, bookmark: false)
            sectionList.setSectionList(todoSize: todoList.getCount())
            tableView.reloadData()
        }
    }
    
    // Event: Push Up Inside
    @objc func bookmarkButtonClicked(_ sender: UIButton) {
        todoList.updateBookmark(at: sender.tag)
        let indexPaths = [IndexPath(row: sender.tag, section:1)]
        tableView.reloadRows(at:indexPaths, with: .none)
    }
    
    // Event: Push Up Inside
    @objc func isDoneButtonClicked(_ sender: UIButton) {
        todoList.updateIsDone(at: sender.tag)
        let indexPaths = [IndexPath(row: sender.tag, section:1)]
        tableView.reloadRows(at:indexPaths, with: .none)
    }
}
