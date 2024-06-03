//
//  ChattingListForthTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 6/2/24.
//

import UIKit

class ChattingListForthTableViewCell: UITableViewCell {

    @IBOutlet weak var firstProfileImageView: UIImageView!
    @IBOutlet weak var secondProfileImageView: UIImageView!
    @IBOutlet weak var thirdProfileImageView: UIImageView!
    @IBOutlet weak var forthProfileImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
    }

    func configLayout() {
        self.selectionStyle = .default
        firstProfileImageView.setLayoutForChatProfile()
        secondProfileImageView.setLayoutForChatProfile()
        thirdProfileImageView.setLayoutForChatProfile()
        forthProfileImageView.setLayoutForChatProfile()
        titleLabel.setLayoutForChatTitle()
        subTitleLabel.setLayoutForChatSubTitle()
        timeLabel.setLayoutForChatTimeLabel()
    }
    
    func configCell(_ data: (ChatRoom, Chat?)) {
        // 테스트 후 여려명 프로필 노출 구현
        for (idx,image) in data.0.chatroomImage.enumerated(){
            switch idx {
            case 0: firstProfileImageView.image = UIImage(named: image)
            case 1: secondProfileImageView.image = UIImage(named: image)
            case 2: thirdProfileImageView.image = UIImage(named: image)
            case 3: forthProfileImageView.image = UIImage(named: image)
            default: return
            }
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
