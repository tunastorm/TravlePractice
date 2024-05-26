//
//  placeholders.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import Foundation

enum Placeholder{
    case restuarantSearch
    
    func get() -> String {
        switch self {
        case .restuarantSearch: return "검색어를 입력해주세요"
        }
    }
}


