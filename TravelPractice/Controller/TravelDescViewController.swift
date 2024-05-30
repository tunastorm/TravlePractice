//
//  TravelDescViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/29/24.
//

import UIKit

class TravelDescViewController: UIViewController {
    
    static let identifier = String(String(describing: type(of: self)).split(separator: " ").last!)
    
    @IBOutlet var travelDescView: UIView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starImageView: UIImageView!
    @IBOutlet var gradeAndSaveLabel: UILabel!
    @IBOutlet var personImageView: UIImageView!
    @IBOutlet var boltImageView: UIImageView!
    @IBOutlet var creditCardImageView: UIImageView!
    @IBOutlet var sailsCountLabel: UILabel!
    @IBOutlet var bookingLabel: UILabel!
    @IBOutlet var installmentLabel: UILabel!
    @IBOutlet var questionImageView: UIImageView!
    
    var data: Travel?
    var systemImage = SystemImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setViewLayout()
        setViewData()
    }
    
    func setViewLayout() {
        mainImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = .systemFont(ofSize: 20)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .gray

        starImageView.tintColor = .systemYellow
        
        gradeAndSaveLabel.font = .boldSystemFont(ofSize: 15)
        
        sailsCountLabel.font = .systemFont(ofSize: 15)
        sailsCountLabel.textAlignment = .left
        
        bookingLabel.font = .systemFont(ofSize: 15)
        bookingLabel.textAlignment = .left
        bookingLabel.numberOfLines = 0
        
        installmentLabel.font = .systemFont(ofSize: 15)
        installmentLabel.textAlignment = .left
        
        questionImageView.contentMode = .scaleToFill
        
    }
    
    func setViewData() {
        
        guard let data, 
              let image = data.travel_image,
              let grade = data.grade,
              let save = data.save
        else {
            return
        }
        
        let url = URL(string: image)
        mainImageView.kf.setImage(with: url)
        
        travelDescView.layer.addBorder([.bottom], color: UIColor.systemGray3, width: 1.0)
        
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        starImageView.image = systemImage.star
        gradeAndSaveLabel.text = "\(grade) ﹒ \(save)회"
        personImageView.image = systemImage.persons
        boltImageView.image = systemImage.bolt
        creditCardImageView.image = systemImage.creditCard
        sailsCountLabel.text = "\(Int.random(in: 0...100000))명의 여행자가 이 상품을 구매했어요"
        bookingLabel.text = "즉시확정 구매즉시 예약확정 (일부 상품 이용일 추가 예약필요)"
        installmentLabel.text = "최대 \(Int.random(in: 3...36))개월 무이자 할부 가능"
        questionImageView.image = systemImage.questionMark
    }
    
    
    func setNavigationBar() {
       navigationItem.setLayoutFortopTitle(title:"", color: .clear, width: view.frame.width, height: 40)
        navigationItem.titleView?.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        let backWordButton = UIBarButtonItem(title: "←", style: .done, target: self, action: #selector(popButtonClicked))
        backWordButton.tintColor = .white
        navigationItem.leftBarButtonItems = [backWordButton]
    }
   
    
    @objc func popButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }


}
