//
//  SearchRestaurantTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit

class SearchRestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var currentKeywordLabel: UILabel!
    
    @IBOutlet weak var scrollViewBase: UIView!
    
    
    lazy var horizontalScrollView: HorizontalScrollView = {
        let view = HorizontalScrollView()
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    
    override func awakeFromNib() {
        configLayout()
    }
    
    func configLayout() {
        self.selectionStyle = .none
        currentKeywordLabel.font = .boldSystemFont(ofSize: 15)
        currentKeywordLabel.textAlignment = .left
    }
    
    func configCell(_ currentWord: String) {
        currentKeywordLabel.text = "최근 검색어"
        configureHorizontalScrollView()
        insertDataSource(currentWord)
    }
    
    func configureHorizontalScrollView() {
        scrollViewBase.addSubview(horizontalScrollView)
        horizontalScrollView.snp.makeConstraints{ make in
            make.center.width.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    func insertDataSource(_ currentWord: String) {
        // 검색된
        horizontalScrollView.dataSource = currentWord
    }
}
