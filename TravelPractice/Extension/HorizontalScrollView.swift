//
//  HorizontalScrollView.swift
//  TravlePractice
//
//  Created by 유철원 on 5/28/24.
//

import UIKit
import SnapKit

class HorizontalScrollView: BaseScrollView {
    var dataSource: String? {
        didSet { bind() }
    }
    var words: [String] = []

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.isUserInteractionEnabled = true

        return view
    }()

    override func configure() {
        super.configure()

        showsHorizontalScrollIndicator = false
        bounces = false
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview() /// 이 값이 없으면 scroll 안되는 것 주의
            make.top.bottom.equalToSuperview()
        }
    }

    override func bind() {
        super.bind()
        guard let word = dataSource else {
            return
        }
        let view = UIView()
        // 최근 검색어로 등록되지 않은 검색어만 추가, 등록된 것은 리턴
        if !words.contains(word){
            stackView.addArrangedSubview(view)
            words.append(word)
        } else {
            return
        }
        
        view.snp.makeConstraints{
            $0.height.equalTo(30)
            $0.width.greaterThanOrEqualTo(40)
        }
        
        
        
        let button = UIButton()
        button.setTitle(word, for: .normal)
        button.setLayoutForSearchedWord()
        button.addTarget(self, action: #selector(searchedButtonClicked), for: .touchUpInside)
        
//          button.setImage(data.iamge, for: .normal)
//          button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -4.0, bottom: 0.0, right: 0.0)
        
        view.addSubview(button)
        view.bringSubviewToFront(button)
                    
        button.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.greaterThanOrEqualTo(40)
//            $0.edges.equalToSuperview()
//            $0.leading.equalToSuperview().offset(0)
//            $0.top.equalToSuperview().offset(0)
//            $0.trailing.equalToSuperview().offset(0)
//            $0.bottom.equalToSuperview().offset(0)
        }
    
//        // 삭제버튼 추가
//        let deleteButton = UIButton()
//        deleteButton.setLayoutForDeleteSearchWord()
//        deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
//        
//        deleteButton.snp.makeConstraints{
//            $0.height.equalTo(3)
//            $0.width.equalTo(3)
//            $0.top.equalTo(view).offset(30)
//            $0.trailing.equalTo(view).offset(100)
//            $0.bottom.equalTo(view).offset(30)
//            $0.leading.equalTo(button).offset(5)
//        }
//        
//        view.addSubview(deleteButton)
//        view.bringSubviewToFront(deleteButton)
    }
    
    
    @objc func deleteButtonClicked(_ sender: UIButton) {
        print("삭제클릭됨")
    }
    
    @objc func searchedButtonClicked(_ sender: UIButton) {
        guard let searchWord = sender.titleLabel?.text else {
            return
        }
        // 구현 쉽다고 버릇 들이면 안 됨...
        NotificationCenter.default.post(name: .SearchFieldText, object: searchWord)
    }

}
