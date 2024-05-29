//
//  HotCountryViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/29/24.
//

import UIKit

class HotCountryViewController: UIViewController {
    
    static let identifier = String(String(describing: type(of: self)).split(separator: " ").last!)
    
    let safetyArea: UIView = {
         let v = UIView()
         v.backgroundColor = .clear
         return v
     }()
    
    lazy var segmentedControl: UISegmentedControl = {
      let control = UISegmentedControl(items: ["모두", "국내", "해외"])
      control.translatesAutoresizingMaskIntoConstraints = false
      return control
    }()
    
    let allView: UIView = {
      let view = UIView()
      view.backgroundColor = .white
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    let domesticView: UIView = {
      let view = UIView()
      view.backgroundColor = .white
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    let abroadView: UIView = {
      let view = UIView()
      view.backgroundColor = .white
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    var showingView: Int? {
        didSet {
            guard let showingView = showingView else { return }
            // 모두 뷰 노출
            if showingView == 0 {
                allView.isHidden = false
                domesticView.isHidden = true
                abroadView.isHidden = true
            // 국내 뷰 노출
            } else if showingView == 1{
                allView.isHidden = true
                domesticView.isHidden = false
                abroadView.isHidden = true
            // 해외 뷰 노출
            } else if showingView == 2 {
                allView.isHidden = true
                domesticView.isHidden = true
                abroadView.isHidden = false
            }
        }
    }
    
    let cellIdentifier = HotCountryTableViewCell.identifier
    
    lazy var searchController = UISearchController(searchResultsController: nil)
    lazy var tableView = UITableView()
    lazy var searchBar = UISearchBar()
    
    //let list = CityInfo().city
    lazy var flattenArr = CityInfo().flattenArr
    lazy var flattenDomestic: [String] = []
    lazy var flattenAbroad: [String] = []
    
    var filterredArr: [String] = []
//    let resultIdxList: [Int] = []
    var isFiltering = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setSafetyArea(safetyArea)
        setView()
        setTableView()
    }
    
   
}

extension HotCountryViewController {
    
    func setNavigationBar() {
        navigationItem.setLayoutFortopTitle(title: "인기 도시", width: view.frame.width, height: view.frame.width)
    }
    
    func setView() {
        setSerchBar()
        setSegmentedControl()
        setTableView()
        setViewAutoLayout()
    }
        
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let xib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 130
        
        safetyArea.addSubview(tableView)
    }
    
    func setViewAutoLayout() {
        searchBar.snp.makeConstraints{
            $0.height.equalTo(30)
//            $0.top.equalToSuperview().inset(20)
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.bottom.equalTo(segmentedControl).inset(20)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl).inset(50) // segmentedControl height(40) + 20
            $0.leading.trailing.equalToSuperview().inset(0)
            $0.bottom.equalToSuperview().inset(0)
        }
    }
    
    func setSerchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchBar = searchController.searchBar
        searchBar.placeholder = "검색할 도시를 입력하세요"
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.searchTextField.textColor = .black

        self.navigationItem.searchController = searchController
    }
    
    func setSegmentedControl() {
        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
          
        self.segmentedControl.selectedSegmentIndex = 0
        self.didChangeValue(segment: self.segmentedControl)
        
        safetyArea.addSubview(segmentedControl)
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        
        self.showingView = segment.selectedSegmentIndex
        
        // 국내, 해외 뷰 최초 클릭 시 초기화
        if showingView == 1 && flattenDomestic.isEmpty ||
           showingView == 2 && flattenAbroad.isEmpty {
            setRegionList()
            return
        }
        
        switch showingView {
        case 0: filterredArr = flattenArr
        case 1: filterredArr = flattenDomestic
        case 2: filterredArr = flattenAbroad
        default: return
        }
        tableView.reloadData()
    }
    
}

extension HotCountryViewController: UISearchBarDelegate {
    
    
    func setRegionList() {
        searchBar.searchTextField.textColor = .clear
        if showingView == 1 {
            searchBar.text = "true"
        } else if showingView  == 2 {
            searchBar.text = "false"
        }
        
        let isSelected = searchQuery(setRegion: false)
        searchBar.text = ""
        searchBar.searchTextField.textColor = .black
    }

    // 검색, allView가 노출되지 않을 때는 지역별 검색 후 쿼리
    func searchQuery(setRegion: Bool) -> Bool {
        var isSelected = false
    
        guard let text = self.searchBar.text?.lowercased() else { return isSelected }
    
        var queryArr: [String] = []
        // 국내 뷰 노출 중 검색
        if setRegion && showingView == 1{
            queryArr = flattenDomestic
        // 해외 뷰 노출 중 겁색
        } else if setRegion && showingView == 2{
            queryArr = flattenAbroad
        // 모두 뷰 노출 중 검색
        } else {
            queryArr = flattenArr
        }
        
        print("queryArr: \(queryArr)")
        // " | "로 구분한 문자열로 변환된 City객체가 담긴 flattenCity와 text를 contains로 비교
//        for (idx, flattenCity) in queryArr.enumerated() {
//            if flattenCity.contains(text) {
//                print("idx_\(idx):\n\(flattenCity)")
//            }
//        }
        
        var resultArr: [String] = []
        if !text.isEmpty {
            resultArr = queryArr.filter { $0.localizedCaseInsensitiveContains(text) }
        } else {
            resultArr = queryArr
        }
        
        filterredArr = resultArr
        // 국내 뷰 리스트 초기화 및 뷰 이동
        if showingView == 1 && flattenDomestic.isEmpty {
            flattenDomestic = resultArr
            tableView.reloadData()
        // 해외 뷰 리스트 초기화 및 뷰 이동
        } else if showingView == 2 && flattenAbroad.isEmpty {
            flattenAbroad = resultArr
            tableView.reloadData()
        }
        
        if filterredArr.count > 0 {
            self.searchBar.text = text
            isSelected = true
        }
        
        return isSelected
    }
    
       // 서치바에서 검색을 시작할 때 호출
       func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
           self.isFiltering = true
           self.searchBar.showsCancelButton = true
           self.tableView.reloadData()
       }
           
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            let isSelected = searchQuery(setRegion: allView.isHidden)
            
            if isSelected {
                self.tableView.reloadData()
            }
        }
    
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           let isSelected = searchQuery(setRegion: allView.isHidden)
           
           if isSelected {
               self.tableView.reloadData()
           }
       }
       
       // 서치바에서 취소 버튼을 눌렀을 때 호출
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           self.searchBar.text = ""
           self.searchBar.resignFirstResponder()
           self.isFiltering = false
           self.tableView.reloadData()
       }
       
       // 서치바 검색이 끝났을 때 호출
       func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
           print("검색결과: \(filterredArr)")
           self.tableView.reloadData()
       }
       
       // 서치바 키보드 내리기
       func dismissKeyboard() {
           searchBar.resignFirstResponder()
       }
    
//      func updateSearchResults(for searchController: UISearchController) {
//          let isSelected = searchQuery()
//          
//          if isSelected {
//              self.tableView.reloadData()
//          }
//      }
}


extension HotCountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowSize = 0
        
        if !allView.isHidden && filterredArr.isEmpty {
            rowSize = flattenArr.count
        } else {
            rowSize = filterredArr.count
        }
        
        return rowSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var data = City(city_name: "", city_english_name: "", city_explain: "", city_image: "", domastic_travel: false)
//        print(indexPath.row)
        
        if !allView.isHidden && filterredArr.isEmpty {
            data.flatten = flattenArr[indexPath.row]
        } else {
            data.flatten = filterredArr[indexPath.row]
        }
//        print("AfterFlattenSetter :\(data)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HotCountryTableViewCell
        
        if !allView.isHidden && filterredArr.isEmpty {
            cell.configCell(data)
        } else {
            guard let word = searchBar.text else {return cell}
            cell.configfilterredCell(data, filter: word)
        }
        
        return cell
    }

}
