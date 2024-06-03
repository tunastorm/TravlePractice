//
//  ChattingRoomViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import UIKit

class ChattingRoomViewController: UIViewController {

    
    @IBOutlet weak var chattingRoomTableView: UITableView!
    
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    var roomData: ChatRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setMessageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let rowSize = self.roomData?.chatList.count else {return}
        let indexPath = IndexPath(row: rowSize-1, section: 0)
        self.chattingRoomTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        if messageView.isFirstResponder {
            messageView.resignFirstResponder()
        }
    }
}

extension ChattingRoomViewController {
    func setTableView() {
        chattingRoomTableView.delegate = self
        chattingRoomTableView.dataSource = self
        
        chattingRoomTableView.separatorStyle = .none
        chattingRoomTableView.sectionHeaderTopPadding = 10
        chattingRoomTableView.sectionHeaderHeight = 10
        chattingRoomTableView.rowHeight = UITableView.automaticDimension
        chattingRoomTableView.backgroundColor = .systemGray6
        
        let myIdentifier = MyChatTableViewCell.identifier
        let otherFirstIdentifier = OtherChatFirstTableViewCell.identifier
        let otherIdentifier = OtherChatTableViewCell.identifier

        let myXib = UINib(nibName: myIdentifier, bundle: nil)
        let otherFirstXib = UINib(nibName: otherFirstIdentifier, bundle: nil)
        let otherXib = UINib(nibName: otherIdentifier, bundle: nil)
        
        chattingRoomTableView.register(myXib, forCellReuseIdentifier: myIdentifier)
        chattingRoomTableView.register(otherFirstXib, forCellReuseIdentifier: otherFirstIdentifier)
        chattingRoomTableView.register(otherXib, forCellReuseIdentifier: otherIdentifier)
    }
    
    func setMessageView() {
        messageTextView.delegate = self
        messageTextView.isScrollEnabled = false
        messageTextView.text = Placeholder.chattingTextView.text
        messageTextView.textColor = .systemGray3
        messageView.backgroundColor = .white
        messageTextView.layer.backgroundColor = UIColor.systemGray6.cgColor
        messageTextView.layer.cornerRadius = messageTextView.frame.height * 0.5
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
            
        } else if data.user != fastUser {
            let identifier = OtherChatFirstTableViewCell.identifier
            let otherFirstCell = chattingRoomTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! OtherChatFirstTableViewCell
            otherFirstCell.configCell(data, fastUser, nextUser)
            cell = otherFirstCell
            
        } else if data.user == fastUser {
            let identifier = OtherChatTableViewCell.identifier
            let otherCell = chattingRoomTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! OtherChatTableViewCell
            otherCell.configCell(data, nextUser)
            cell = otherCell
        }
        
        return cell
    }
}

extension ChattingRoomViewController: UITextViewDelegate {
    
    // 편집 시작, 커서 시작
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.systemGray3 {
            textView.text = nil
        }
        textView.textColor = .black
        textView.becomeFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            let size = CGSize(width: view.frame.width, height: .infinity)
            let estimatedSize = textView.sizeThatFits(size)
            
            textView.constraints.forEach { (constraint) in
              /// height가 30 이상 70이하일 때만 height 증가 (세 줄 증가)
                if 30 <= estimatedSize.height && estimatedSize.height <= 70 {
                    if constraint.firstAttribute == .height {
                        constraint.constant = estimatedSize.height
                    }
                }
            }
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }

    // 편집 끝, 커서 안 보임
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == messageTextView && textView.text.isEmpty {
            textView.text = Placeholder.chattingTextView.text
            textView.textColor = .systemGray3
        }
    }
    
}
