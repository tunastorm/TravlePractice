//
//  ChattingListViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import UIKit

class ChattingListViewController: UIViewController {

    
    @IBOutlet weak var chattingListTableView: UITableView!
    
    var searchController: UISearchController?
    var searchBar: UISearchBar?
    
    let chatList = mockChatList
    var filterredArr: [ChatRoom] = [] //{
//        didSet {
//            if filterredArr.isEmpty {
//                filterredArr = chatList
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setSearchBar()
    }
    
}

extension ChattingListViewController {
    func setTableView() {
        chattingListTableView.delegate = self
        chattingListTableView.dataSource = self
        chattingListTableView.separatorStyle = .none
        
        let identifier = ChattingListTableViewCell.identifier
        let xib = UINib(nibName: identifier, bundle: nil)
        chattingListTableView.register(xib, forCellReuseIdentifier: identifier)
    }
    
    func setSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchBar = searchController?.searchBar
        searchBar?.placeholder = "검색어를 입력하세요"
        searchBar?.delegate = self
        searchBar?.showsCancelButton = false
        searchBar?.searchTextField.textColor = .black
        searchBar?.tintColor = .black

        self.navigationItem.searchController = searchController
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
        
        vc.roomData = filterredArr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
}

extension ChattingListViewController: UISearchBarDelegate {

    // 검색, allView가 노출되지 않을 때는 지역별 검색 후 쿼리
    func searchQuery() -> Bool {
        var isSelected = false
    
        guard let text = self.searchBar?.text?.lowercased() else { return isSelected }
    
        let queryArr = chatList
        
        var resultArr: [ChatRoom] = []
        if !text.isEmpty {
            // chatroomName으로 검색
            resultArr = queryArr.filter {
                $0.chatroomName.localizedCaseInsensitiveContains(text)
            }
            print("- \(text), chatroomName 검색 후 resultArr:\n\(resultArr)")
            // chatList로 검색
            for chatRoom in queryArr {
                let arr = chatRoom.chatList.filter {
                    $0.user.rawValue.localizedCaseInsensitiveContains(text)
                    || $0.message.localizedCaseInsensitiveContains(text)
                    || $0.date.localizedCaseInsensitiveContains(text)
                }
                print("- \(text), chatList 검색 후 arr:\n\(arr)")
                // 검색결과 resultArr에 append
                if !arr.isEmpty {
                    resultArr.append(chatRoom)
                }
            }
            print("- \(text), chatList 검색 후 resultArr:\n\(resultArr)")
        } else {
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
