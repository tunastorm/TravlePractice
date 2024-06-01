//
//  ChattingListTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import UIKit

class ChattingListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
    }

    func configLayout() {
        self.selectionStyle = .default
    }
    
    func configCell(_ data: ChatRoom) {
        // 테스트 후 여려명 프로필 노출 구현
        
        if let name = data.chatroomImage.first {
            let image = UIImage(named: name)
            profileImageView.image = image
        }
        
        titleLabel.text = data.chatroomName
        subTitleLabel.text = data.chatList.last?.message
        
        if let rawDate = data.chatList.last?.date {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Locale.current.identifier)
            dateFormatter.dateStyle = .long
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            guard let oldDate = dateFormatter.date(from: rawDate) else {return}
            
            dateFormatter.dateFormat = "a HH:mm"
            let newDate = dateFormatter.string(from: oldDate)
            
            timeLabel.text = newDate
        }
    }
    
}