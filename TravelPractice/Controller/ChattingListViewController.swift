//
//  ChattingListViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import UIKit

class ChattingListViewController: UIViewController {

    
    @IBOutlet weak var chattingListTableView: UITableView!
    
    @IBOutlet weak var friendButton: UIButton!
    @IBOutlet weak var chattingRoomButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    
    var searchController: UISearchController?
    var searchBar: UISearchBar?
    
    var chatRoomList: [(ChatRoom, Chat?)] = []
    var filterredArr: [(ChatRoom, Chat?)] = [] //{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChatRoomList(mockList: mockChatList)
        setTableView()
        setNavigationBar()
        setSearchBar()
        setSearchButtons()
    }
    
}

extension ChattingListViewController {
    func setChatRoomList(mockList: [ChatRoom]) {
        for chatRoom in mockList {
            chatRoomList.append((chatRoom, chatRoom.chatList.last))
        }
    }
    
    func setTableView() {
        chattingListTableView.delegate = self
        chattingListTableView.dataSource = self
        chattingListTableView.separatorStyle = .none
        
        let identifier = ChattingListTableViewCell.identifier
        let xib = UINib(nibName: identifier, bundle: nil)
        chattingListTableView.register(xib, forCellReuseIdentifier: identifier)
    }
    
    func setNavigationBar() {
        navigationItem.title = "TRAVEL TALK"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setSearchBar() {
        self.view.tintColor = .black
        searchController = UISearchController(searchResultsController: nil)
    
        if let searchBar = searchController?.searchBar {
            searchBar.placeholder = "검색어를 입력하세요"
            searchBar.delegate = self
            searchBar.showsCancelButton = true
        
            searchBar.searchTextField.textColor = .black
            searchBar.tintColor = .black
            searchBar.barTintColor = .black
            
            let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            UIBarButtonItem.appearance().tintColor = .black
            
            if let text = searchBar.text,
                   text.count == 0 && filterredArr.isEmpty {
                filterredArr = chatRoomList
            }
            self.searchBar = searchBar
        }
        
        self.navigationItem.searchController = searchController
        self.navigationItem.preferredSearchBarPlacement = .inline
    }
    
    func setSearchButtons() {
        var newButtons: [UIButton] = []
        let titles = ["친구", "채팅방", "메시지"]
        
        for title in titles {
            let button = UIButton()
            button.titleLabel?.text = title
            button.tintColor = .darkGray
            button.addTarget(self, action: #selector(searchByButton), for: .touchUpInside)
            newButtons.append(button)
        }
        
        let stackView = UIStackView()
        for newButton in newButtons {
            stackView.addSubview(newButton)
        }
        
        let view = UIView()
        view.addSubview(stackView)
        navigationController?.navigationBar.addSubview(view)
    }
    
    @objc func searchByButton(_ sender: UIButton) {
        print("버튼 눌림")
    }
    
    @objc func showSearchBar() {
        
    }
}


extension ChattingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterredArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowIndex = indexPath.row
        let data = filterredArr[rowIndex]
        
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
        
        vc.roomData = filterredArr[indexPath.row].0
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChattingListViewController: UISearchBarDelegate {

    // 검색, allView가 노출되지 않을 때는 지역별 검색 후 쿼리
    func searchQuery() -> Bool {
        var isSelected = false
    
        guard let text = self.searchBar?.text?.lowercased() else { return isSelected }
        
        let queryArr = chatRoomList
        
        var resultArr: [(ChatRoom, Chat?)] = []
        if !text.isEmpty {
            print(#function + "!text.isEmpty")
            // chatroomName으로 검색
            resultArr = queryArr.filter {
                $0.0.chatroomName.localizedCaseInsensitiveContains(text)
            }
//            // 검색된 Chatroom의 id 저장
//            for result in resultArr {
//                resultIdxList.append(result.chatroomId)
//            }
            print("- \(text), chatroomName 검색 후 resultArr:\n\(resultArr)")
            // chatList로 검색
            for chatRoomTuple in queryArr {
                print("- \(text), chatRoom \(chatRoomTuple.0.chatroomId) 검색")
//                // 채팅방 명으로 검색된 Chatroom일 경우 검색하지 않음
//                if resultIdxList.contains(chatRoom.chatroomId) {
//                    continue
//                }
                
                let chatArr = chatRoomTuple.0.chatList.filter {
                    $0.user.rawValue.localizedCaseInsensitiveContains(text)
                    || $0.message.localizedCaseInsensitiveContains(text)
                    || $0.date.localizedCaseInsensitiveContains(text)
                }
                
                print("- \(text), chatList 검색 후 arr:\n\(chatArr)")
                // 검색결과 resultArr에 append
                if !chatArr.isEmpty {
                    for chat in chatArr {
                        resultArr.append((chatRoomTuple.0, chat))
                    }
                }
            }
            print("- \(text), chatList 검색 후 resultArr:\n\(resultArr)")
        }
        
        if resultArr.isEmpty {
            resultArr = queryArr
        }
        
        filterredArr = resultArr
        print("- \(text), 검색완료 후 filterredArr:\n\(filterredArr)")
        
        if filterredArr.count > 0 {
            self.searchBar?.text = text.capitalized
            isSelected = true
        }
        
        return isSelected
    }
    
       // 서치바에서 검색을 시작할 때 호출
       func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
           self.searchBar?.showsCancelButton = true
           self.becomeFirstResponder()
           chattingListTableView.reloadData()
       }
    
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           print(#function)
           let isSelected = searchQuery()
           
           if isSelected {
               chattingListTableView.reloadData()
           }
       }
       
       // 서치바에서 취소 버튼을 눌렀을 때 호출
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           self.searchBar?.text = ""
           self.searchBar?.resignFirstResponder()
           chattingListTableView.reloadData()
       }
       
       // 서치바 검색이 끝났을 때 호출
       func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
           // print("검색결과: \(filterredArr)")
           chattingListTableView.reloadData()
       }
       
       // 서치바 키보드 내리기
       func dismissKeyboard() {
           searchBar?.resignFirstResponder()
       }
}
