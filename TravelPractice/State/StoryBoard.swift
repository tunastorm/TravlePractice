//
//  StoryBoardName.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import Foundation

enum StoryBoard {
    case Main
    case Advertisement
    case HotCountry
    case Restaurantmap
    case Chatting
    
    var name: String {
        String(describing: self)
    }
}
