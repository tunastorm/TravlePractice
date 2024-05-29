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
            if showingView == 0 {
                allView.isHidden = false
                domesticView.isHidden = true
                abroadView.isHidden = true
                
            } else if showingView == 1{
                allView.isHidden = true
                domesticView.isHidden = false
                abroadView.isHidden = true
                
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
    
    let list = CityInfo().city
    let flattenArr = CityInfo().flattenArr
    var filterredArr: [String] = []
//    let resultIdxList: [Int] = []
    var isFiltering = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(flattenArr)
        
        setNavigationBar()
        setBaseView()
        setView()
        setTableView()
    }
    
    func setBaseView(){
         safetyArea.translatesAutoresizingMaskIntoConstraints = false // 코드로 제약조건을 주기위해서 꼭 들어가야 하는 코드
         view.addSubview(safetyArea)
         if #available(iOS 11, *) {
             let guide = view.safeAreaLayoutGuide
             safetyArea.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
             safetyArea.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
             safetyArea.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
             safetyArea.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
             
         } else {
             safetyArea.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
             safetyArea.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
             safetyArea.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
             safetyArea.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         }
    }
    
    func setNavigationBar() {
        navigationItem.setLayoutFortopTitle(title: "인기 도시", width: view.frame.width, height: view.frame.width)
    }
    
    func setView() {
        setSerchBar()
        setSegmentedControl()
        setTableView()
        setViewAutoLayout()
    }
    
    func setSerchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchBar = searchController.searchBar
        searchBar.placeholder = "검색창입니다"
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        

        self.navigationItem.searchController = searchController

        // text가 업데이트될 때마다 불리는 메소드
        searchController.searchResultsUpdater = self
    }
    
    func setSegmentedControl() {
        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
          
        self.segmentedControl.selectedSegmentIndex = 0
        self.didChangeValue(segment: self.segmentedControl)
        
        safetyArea.addSubview(segmentedControl)
    }
    
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
      self.showingView = segment.selectedSegmentIndex
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
}

extension HotCountryViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    // 서치바에서 검색을 시작할 때 호출
       func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
           self.isFiltering = true
           self.searchBar.showsCancelButton = true
           self.tableView.reloadData()
       }
       
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           guard let text = self.searchBar.text?.lowercased() else { return }
           print(text)
           for (idx, flatten) in flattenArr.enumerated() {
               if flatten.contains(text) {
                   print("idx_\(idx):\n\(flatten)")
               }
           }
           self.filterredArr = flattenArr.filter { $0.localizedCaseInsensitiveContains(text) }
           
           if filterredArr.count > 0 {
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
    
      func updateSearchResults(for searchController: UISearchController) {
          guard let text = searchController.searchBar.text else {
              return
          }
          
      }
    
}


extension HotCountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowSize = 0
        
        if !allView.isHidden && filterredArr.isEmpty {
            rowSize = list.count
        } else {
            rowSize = filterredArr.count
        }
        
        return rowSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var data: City
        if !allView.isHidden && filterredArr.isEmpty {
            data = list[indexPath.row]
        } else {
            data = City(city_name: "", city_english_name: "", city_explain: "", city_image: "", domastic_travel: false)
            data.flatten = filterredArr[indexPath.row]
            print("AfterFlattenSetter :\(data)")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HotCountryTableViewCell
        
        cell.configCell(data)
        
        return cell
    }

}
