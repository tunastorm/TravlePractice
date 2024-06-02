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
    
    var roomIndex: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
    }

    func configLayout() {
        self.selectionStyle = .default
        profileImageView.setLayoutForChatProfile()
    }
    
    func configCell(_ data: (ChatRoom, Chat?)) {
        // 테스트 후 여려명 프로필 노출 구현
        
        if let name = data.0.chatroomImage.first {
            let image = UIImage(named: name)
            profileImageView.image = image
        }
        
        titleLabel.text = "\(data.0.chatroomName) \(data.0.chatroomImage.count + 1)명"
        
        guard let subtitle = data.1?.message else {return}
        subTitleLabel.text = subtitle
        
        if let rawDate = data.0.chatList.last?.date {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Locale.current.identifier)
            dateFormatter.dateStyle = .long
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let oldDate = dateFormatter.date(from: rawDate) else {return}
            
            dateFormatter.dateFormat = "a h:mm"
            let newDate = dateFormatter.string(from: oldDate)
            
            timeLabel.text = newDate
        }
    }
    
}
