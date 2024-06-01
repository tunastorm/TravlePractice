//
//  ChattingRoomViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import UIKit

class ChattingRoomViewController: UIViewController {

    
    @IBOutlet weak var chattingRoomTableView: UITableView!
    
    var roomData: ChatRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    
}

extension ChattingRoomViewController {
    func setTableView() {
        chattingRoomTableView.delegate = self
        chattingRoomTableView.dataSource = self
        chattingRoomTableView.separatorStyle = .none
        chattingRoomTableView.sectionHeaderTopPadding = 10

        let myIdentifier = MyChatTableViewCell.identifier
        let otherIdentifier = OtherChatTableViewCell.identifier
        let myXib = UINib(nibName: myIdentifier, bundle: nil)
        let otherXib = UINib(nibName: otherIdentifier, bundle: nil)
        chattingRoomTableView.register(myXib, forCellReuseIdentifier: myIdentifier)
        chattingRoomTableView.register(otherXib, forCellReuseIdentifier: otherIdentifier)
    }
}

extension ChattingRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomData?.chatList.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowIndex = indexPath.row
        var cell = UITableViewCell()
        var fastUser: User?
        var nextUser: User?
       
        guard let data = roomData?.chatList[rowIndex] else {return cell}
        
        let nowUser = data.user
        
        if rowIndex > 0 {
            fastUser = roomData?.chatList[rowIndex-1].user
        }
        
        if rowIndex < (roomData?.chatList.count ?? 1)-1 {
            nextUser = roomData?.chatList[rowIndex+1].user
        }
        
        if data.user == .user {
            let identifier = MyChatTableViewCell.identifier
            let myCell = chattingRoomTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyChatTableViewCell
            myCell.configCell(data, nextUser)
            cell = myCell
        } else {
            let identifier = OtherChatTableViewCell.identifier
            let otherCell = chattingRoomTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! OtherChatTableViewCell
            otherCell.configCell(data, fastUser, nextUser)
            cell = otherCell
        }
        
        return cell
    }
    
}
