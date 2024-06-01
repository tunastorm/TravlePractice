//
//  ChattingListViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import UIKit

class ChattingListViewController: UIViewController {

    
    @IBOutlet weak var chattingListTableView: UITableView!
    
    
    let chatList = mockChatList
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
}

extension ChattingListViewController {
    func setTableView() {
        chattingListTableView.delegate = self
        chattingListTableView.dataSource = self
        
        let identifier = ChattingListTableViewCell.identifier
        let xib = UINib(nibName: identifier, bundle: nil)
        chattingListTableView.register(xib, forCellReuseIdentifier: identifier)
    }
}


extension ChattingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowIndex = indexPath.row
        let data = chatList[rowIndex]
        
        let identifier = ChattingListTableViewCell.identifier
        let cell = chattingListTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ChattingListTableViewCell
        
        cell.configCell(data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let identifier = ChattingRoomViewController.identifier
        let cell = tableView.cellForRow(at: indexPath) as! ChattingListTableViewCell
        
        let sb = UIStoryboard(name: StoryBoard.Chatting.name, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: identifier) as! ChattingRoomViewController
        // search 메뉴 생기면 filtteredList에서 가져와도 됨
        
        vc.roomData = chatList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
}
