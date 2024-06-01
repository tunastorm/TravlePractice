//
//  MyChatTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {

    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var chatTimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
    }

    func configLayout() {
        chatLabel.textAlignment = .left
        chatLabel.numberOfLines = 0
        chatLabel.backgroundColor = .yellow
        chatLabel.layer.cornerRadius = 10
        chatLabel.layer.masksToBounds = true
    }
    
    func configCell(_ data: Chat, _ nextUser: User?) {
        
        chatLabel.text = data.message
        
        if data.user != nextUser {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Locale.current.identifier)
            dateFormatter.dateStyle = .long
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let oldDate = dateFormatter.date(from: data.date) else {return}
            
            dateFormatter.dateFormat = "a h:mm"
            let newDate = dateFormatter.string(from: oldDate)
            
            chatTimeLabel.text = newDate
        }
    }
}
