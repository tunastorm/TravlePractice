//
//  ChattingRoomViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import UIKit
import NotificationCenter

class ChattingRoomViewController: UIViewController {

    
    @IBOutlet weak var chattingRoomTableView: UITableView!
    
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var messageViewConstraint: NSLayoutConstraint!
    
    var roomData: ChatRoom?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setTableView()
        registerCells()
        setMessageView()
        setKeyboardNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let rowSize = self.roomData?.chatList.count else {return}
        let indexPath = IndexPath(row: rowSize-1, section: 0)
        self.chattingRoomTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // observer를 전부 제거
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        if messageView.isFirstResponder {
            messageView.resignFirstResponder()
        }
    }
    
    func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:NSNotification) {
        print("hihihihihihi")
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            print("keyboardHeight = \(keyboardHeight)")
            
            let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0
            
            messageViewConstraint.constant = -(keyboardHeight - tabBarHeight)
            UIView.animate(withDuration: 0.5, delay: 0.1,
                           options: UIView.AnimationOptions.transitionCurlUp,
                           animations: { self.messageView.layoutIfNeeded()
                                         self.chattingRoomTableView.layoutIfNeeded()
            }, completion: nil)
            
            guard let rowSize = self.roomData?.chatList.count else {return}
            let indexPath = IndexPath(row: rowSize-1, section: 0)
            chattingRoomTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    @objc func keyboardWillHide(_ notification:NSNotification) {
        messageViewConstraint.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0.1,
                       options: UIView.AnimationOptions.transitionCurlUp,
                       animations: { self.messageView.layoutIfNeeded()
                                     self.chattingRoomTableView.layoutIfNeeded()
        }, completion: nil)
    }
}

extension ChattingRoomViewController {
    
    func setNavigationBar() {
        if let titleText = roomData?.chatroomName {
            navigationItem.title = titleText
        }
    }
    
    func setTableView() {
        chattingRoomTableView.delegate = self
        chattingRoomTableView.dataSource = self
        
        chattingRoomTableView.separatorStyle = .none
        chattingRoomTableView.sectionHeaderTopPadding = 10
        chattingRoomTableView.sectionHeaderHeight = 10
        chattingRoomTableView.rowHeight = UITableView.automaticDimension
        chattingRoomTableView.backgroundColor = .white
    }
    
    func registerCells() {
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
        messageTextView.layer.cornerRadius = messageTextView.frame.height * 0.2
    }
}

extension ChattingRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomData?.chatList.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowIndex = indexPath.row
        var cell = UITableViewCell()
        
        var fastDate: String?
        var fastUser: User?
        var nextUser: User?
        
        
        guard let data = roomData?.chatList[rowIndex] else {return cell}
        
        let nowUser = data.user
        
        if rowIndex > 0 {
            fastUser = roomData?.chatList[rowIndex-1].user
            fastDate = roomData?.chatList[rowIndex-1].date
        }
        
        if rowIndex < (roomData?.chatList.count ?? 1)-1 {
            nextUser = roomData?.chatList[rowIndex+1].user
        }
        
        if data.user == .user {
            let identifier = MyChatTableViewCell.identifier
            let myCell = chattingRoomTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyChatTableViewCell
            myCell.configCell(data, fastDate, nextUser)
            cell = myCell
            
        } else if data.user != fastUser {
            let identifier = OtherChatFirstTableViewCell.identifier
            let otherFirstCell = chattingRoomTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! OtherChatFirstTableViewCell
            otherFirstCell.configCell(data, fastDate, fastUser, nextUser)
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
