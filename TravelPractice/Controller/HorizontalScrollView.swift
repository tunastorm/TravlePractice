//
//  HorizontalScrollView.swift
//  TravlePractice
//
//  Created by 유철원 on 5/28/24.
//

import UIKit
import SnapKit

class HorizontalScrollView: BaseScrollView {
    var dataSource: [String]? {
        didSet { bind() }
    }
    var titles: [String] = []

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10

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
        
        dataSource?.forEach { word in
            let button = UIButton()
            button.setTitle(word, for: .normal)
            button.setLayoutForSearchedWord()
//            button.setImage(data.iamge, for: .normal)
//            button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -4.0, bottom: 0.0, right: 0.0)

            button.snp.makeConstraints { make in
                make.height.equalTo(30)
                make.width.greaterThanOrEqualTo(40)
            }
            
            if !titles.contains(word){
                stackView.addArrangedSubview(button)
                titles.append(word)
            }
        }
    }

}
