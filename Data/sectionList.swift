//
//  restaurantSectionList.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import Foundation


struct Section: Codable {
    let header: String
    let footer: String
    var rowSize: Int
}

struct SectionList {
    private var sectionList: [Section]
    
    init() {
        if let list = UserDefaultsManager.sectionList {
            self.sectionList = list
        } else {
            sectionList = [
               Section(header: " ", footer: " ", rowSize: 1),
               Section(header: " ", footer: " ", rowSize: 10)
            ]
            UserDefaultsManager.sectionList = self.sectionList
        }
        print(sectionList.count)
        print(sectionList)
    }
    
    func getSectionList() -> [Section] {
        return self.sectionList
    }
    
    func getSection(at index: Int) -> Section {
        return self.sectionList[index]
    }
    
    mutating func setSectionList(restaurantSize: Int) {
        self.sectionList[1].rowSize = restaurantSize
        UserDefaultsManager.sectionList = self.sectionList
    }
}
