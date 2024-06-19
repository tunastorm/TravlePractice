//
//  RestuarantMapViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/30/24.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var authorizationStatus: CLAuthorizationStatus?
    
    
    lazy var segmentedControl: UISegmentedControl = {
      let control = UISegmentedControl(items: ["전체", "한식", "양식", "중식", "일식"])
      control.translatesAutoresizingMaskIntoConstraints = false
      return control
    }()
    
    let allView: UIView = {
      let view = UIView()
      view.backgroundColor = .white
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    let korView: UIView = {
      let view = UIView()
      view.backgroundColor = .white
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    let westView: UIView = {
      let view = UIView()
      view.backgroundColor = .white
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    let chinView: UIView = {
      let view = UIView()
      view.backgroundColor = .white
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    let japView: UIView = {
      let view = UIView()
      view.backgroundColor = .white
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    
    var showingView: Int? {
        didSet {
            guard let showingView = showingView else { return }
            
            // 전체
            if showingView == 0 {
                allView.isHidden = false
                korView.isHidden = true
                westView.isHidden = true
                chinView.isHidden = true
                japView.isHidden = true
            // 한식
            } else if showingView == 1 {
                allView.isHidden = true
                korView.isHidden = false
                westView.isHidden = true
                chinView.isHidden = true
                japView.isHidden = true
            // 양식
            } else if showingView == 2 {
                allView.isHidden = true
                korView.isHidden = true
                westView.isHidden = false
                chinView.isHidden = true
                japView.isHidden = true
            // 중식
            } else if showingView == 3 {
                allView.isHidden = true
                korView.isHidden = true
                westView.isHidden = true
                chinView.isHidden = false
                japView.isHidden = true
            // 일식
            } else if showingView == 4 {
                allView.isHidden = true
                korView.isHidden = true
                westView.isHidden = true
                chinView.isHidden = true
                japView.isHidden = false
            }
        }
    }
    
    var allData: [Restaurant]?
    var korArr: [Restaurant] = []
    var westArr: [Restaurant] = []
    var chinArr: [Restaurant] = []
    var japArr: [Restaurant] = []
    
    var searchIdxList: [Int] = []
    var filterredArr: [Restaurant] = [] {
        didSet {
            mapView.removeAnnotations(mapView.annotations)
                
            for (idx, restaurant) in filterredArr.enumerated() {
                let location = CLLocationCoordinate2D(latitude: restaurant.latitude, 
                                                      longitude: restaurant.longitude)
                
                if idx == 1 {
                    mapView.region = MKCoordinateRegion(center: location, 
                                                        latitudinalMeters: 500,
                                                        longitudinalMeters: 500)
                }
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = restaurant.name
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    var searchTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setNavigationBar()
        setSearhTextField()
        setSegmentedControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkDeviceLocationAuthorization()
    }
}


extension RestaurantMapViewController {
    func setDelegate() {
        mapView.delegate = self
        locationManager.delegate = self
        searchTextField.delegate = self
    }
    
    func setNavigationBar() {
        navigationItem.setLayoutFortopTitle(title: "지도에서 찾기", color: .black ,width: view.frame.width, height: view.frame.width)
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    func setSearhTextField() {
        searchTextField.textColor = .clear
        searchTextField.borderStyle = .none
        searchTextField.backgroundColor = .clear
        
        view.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints{
            $0.top.equalToSuperview().inset(0)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setSegmentedControl() {
        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
          
        self.segmentedControl.selectedSegmentIndex = 0
        self.didChangeValue(segment: self.segmentedControl)
        
        view.addSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.bottom.equalToSuperview().inset(120)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        
        self.showingView = segment.selectedSegmentIndex
        
        // 국내, 해외 뷰 최초 클릭 시 초기화
        if showingView == 1 && korArr.isEmpty ||
           showingView == 2 && westArr.isEmpty ||
           showingView == 3 && chinArr.isEmpty ||
           showingView == 4 && japArr.isEmpty {
            setCategoryList()
            return
        }
        
        guard let allData else {return}
        
        switch showingView {
        case 0: filterredArr = allData
        case 1: filterredArr = korArr
        case 2: filterredArr = westArr
        case 3: filterredArr = chinArr
        case 4: filterredArr = japArr
        default: return
        }
    }
    
    func configUserLocationButton() {
        var image: UIImage?
        switch authorizationStatus {
        case .notDetermined, .denied:
            image = UIImage(systemName: "location")!
        case .authorizedWhenInUse, .authorizedAlways:
            image = UIImage(systemName: "location.fill")!
        default: print(authorizationStatus)
        }
        
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(setUserLocation))
        barButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func setUserLocation(_ sender: UIButton) {
        checkDeviceLocationAuthorization()
    }
    
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                var status: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    status = self.locationManager.authorizationStatus
                } else {
                    status = CLLocationManager.authorizationStatus()
                }
                
                self.authorizationStatus = status
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status)
                    self.configUserLocationButton()
                }
            } else {
                print("위치 서비스 꺼져있음")
            }
        }

    }
    
    func checkCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print(#function, status, status.rawValue)
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            let coordinate = CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463)
            setRegionAndAnnotation(center: coordinate)
            showLocationSettingAlert()
        case .authorizedWhenInUse:
            print(#function, status, status.rawValue)
            locationManager.startUpdatingLocation()
        default: print(#function, status)
        }
    }
        
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center,
                                        latitudinalMeters: 500,
                                        longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용",
                                      message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치서비스를 켜주세요",
                                      preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(goSetting)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

extension RestaurantMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(#function)
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            print(coordinate.latitude)
            print(coordinate.longitude)
            setRegionAndAnnotation(center: coordinate)
            return
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function, error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkDeviceLocationAuthorization()
    }
}


extension RestaurantMapViewController: UITextFieldDelegate {
    func setCategoryList() {
        searchTextField.textColor = .clear
        
        switch showingView {
        case 1: searchTextField.text = "한식"
        case 2: searchTextField.text = "양식"
        case 3: searchTextField.text = "중식"
        case 4: searchTextField.text = "일식"
        default: return
        }
        searchQuery(setCategory: false)
        searchTextField.text = ""
    }

    // 검색, 노출되지 않을 때는 지역별 검색 후 쿼리
    func searchQuery(setCategory: Bool) {
        
        // 검색어 널 체크 및 전처리 후 할당
        guard let allData,
              let text = self.searchTextField.text?.lowercased().replacing(" ", with: "") else {return}
        
        filterredArr.removeAll()
    
        var queryArr: [Restaurant] = []
        // 한식 검색
        if setCategory && showingView == 1 {
            queryArr = korArr
        // 양식 검색
        } else if setCategory && showingView == 2 {
            queryArr = westArr
        // 중식 검색
        } else if setCategory && showingView == 3  {
            queryArr = chinArr
        // 일식 검색
        } else if setCategory && showingView == 4  {
            queryArr = japArr
        // 전체 검색
        } else {
            queryArr = allData
        }
        
        // 입력
        var resultArr: [Restaurant] = []
        if !text.isEmpty {
            searchRestaurants(queryArr, word: text)
            if searchIdxList.count > 0 {
                for idx in searchIdxList {
                    resultArr.append(allData[idx])
                }
            }
        } else {
            resultArr = queryArr
        }
        
        // 화면에 노출할 검색결과 저장
        filterredArr = resultArr
        // 한식리스트 초기화
        if showingView == 1 && korArr.isEmpty {
            korArr = resultArr
        // 양식리스트 초기화
        } else if showingView == 2 && westArr.isEmpty {
            westArr = resultArr
        // 중식리스트 초기화
        } else if showingView == 3 && chinArr.isEmpty {
            chinArr = resultArr
        // 일식리스트 초기화
        } else if showingView == 4 && japArr.isEmpty {
            japArr = resultArr
        }
        
//        print("showingView: \(showingView)\ncount:\(filterredArr.count)\nfilterredArr: \(filterredArr)")
    }
    
    // 검색된 레스토랑들의 index를 프로퍼티에 저장
    func searchRestaurants( _ queryArr: [Restaurant], word: String) {
        
        //
        searchIdxList.removeAll()
        
        for restaurant in queryArr {
            if restaurant.category.contains(word) {
                searchIdxList.append(restaurant.idx)
                continue
            }
            if restaurant.name.contains(word) {
                searchIdxList.append(restaurant.idx)
                continue
            }
            if restaurant.address.contains(word) {
                searchIdxList.append(restaurant.idx)
                continue
            }
            if restaurant.phoneNumber.contains(word) {
                searchIdxList.append(restaurant.idx)
                continue
            }
            if String(restaurant.price).contains(word) {
                searchIdxList.append(restaurant.idx)
                continue
            }
        }
        print("searchIdxList: \(searchIdxList)")
    }
}

extension RestaurantMapViewController: MKMapViewDelegate {
    // any(5.6) vs some(5.1) : Opaque Type
    func mapView(_ mapView: MKMapView, didSelect annotation: any MKAnnotation) {
//        print(#function)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        print(#function)
    }
}
