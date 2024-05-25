//
//  File.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import Foundation

enum CellIdentifiers: String, CaseIterable {
    case MagazineTableViewCell
    case RestaurantTableViewCell
    case SearchRestaurantTableViewCell
    
    var describe: String {
        return String(describing: self)
    }
    
//    CellIdentifiers.allCases.forEach{
//        print($0.kind)
//    }
}
