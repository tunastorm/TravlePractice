//
//  MyChatTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import UIKit

class OtherChatTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var chatTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
    }
    
    func configLayout() {
    
    }
    
    func configCell(_ data: Chat, _ isContinue: Bool) {
        
        if isContinue {
            profileImageView.backgroundColor = .clear
            profileImageView.layer.borderWidth = 0
        } else {
            profileImageView.image = UIImage(named: data.user.rawValue)
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Locale.current.identifier)
            dateFormatter.dateStyle = .long
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let oldDate = dateFormatter.date(from: data.date) else {return}
            
            dateFormatter.dateFormat = "a h:mm"
            let newDate = dateFormatter.string(from: oldDate)
            
            chatTimeLabel.text = newDate
        }
        chatLabel.text = data.message
    }
    
}
