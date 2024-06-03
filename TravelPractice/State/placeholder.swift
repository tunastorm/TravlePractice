//
//  placeholders.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit

enum Placeholder: String {
    case restaurantSearch
    case chattingTextView
    
    var text: String {
        switch self {
        case .restaurantSearch: return "검색어를 입력해주세요"
        case .chattingTextView: return "메시지를 입력하세요"
        }
    }
}

