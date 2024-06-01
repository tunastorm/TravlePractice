//
//  ChattingRoomViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import UIKit

class ChattingRoomViewController: UIViewController {

    var roomData: ChatRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    
    
}

extension ChattingRoomViewController {
    
}

extension ChattingRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomData?.chatList.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        return cell
    }
    
    
}
