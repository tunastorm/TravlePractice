//
//  MagazineList.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit

struct MagazineDAO {
    
    private var magazineList: [Magazine]
    
    
    init() {
        if let list = UserDefaultsManager.magazineList {
            magazineList = list
        } else {
            magazineList = MagazineInfo().magazines
            UserDefaultsManager.magazineList = self.magazineList
        }
    }
    
    func getCount() -> Int{
        return magazineList.count
    }
    
    func getmagazineList() -> [Magazine] {
        return magazineList
    }
    
    func getmagazine(at index: Int) -> Magazine {
        return magazineList[index]
    }
    
    mutating func append(title: String, subtitle: String, photoImage: String, date: String, link: String) {
        let magazine = Magazine(title: title, subtitle: subtitle, photo_image: photoImage, date: date, link: link)
        self.magazineList.append(magazine)
        UserDefaultsManager.magazineList = self.magazineList
    }
    
    mutating func delete(at index: Int) {
        self.magazineList.remove(at: index)
        UserDefaultsManager.magazineList = self.magazineList
    }
    
    mutating func update(at index: Int, magazine: Magazine) {
        self.magazineList[index] = magazine
        UserDefaultsManager.magazineList = self.magazineList
    }
    
    mutating func update(at index: Int, title: String) {
        self.magazineList[index].title = title
        UserDefaultsManager.magazineList = self.magazineList
    }
    
    mutating func update(at index: Int, subtitle: String) {
        self.magazineList[index].subtitle = subtitle
        UserDefaultsManager.magazineList = self.magazineList
    }
    
    mutating func update(at index: Int, photoImage: String) {
        self.magazineList[index].photo_image = photoImage
        UserDefaultsManager.magazineList = self.magazineList
    }
    
    mutating func update(at index: Int, link: String) {
        self.magazineList[index].link = link
        UserDefaultsManager.magazineList = self.magazineList
    }
    
    mutating func update(at index: Int, date: String) {
        self.magazineList[index].date = date
        UserDefaultsManager.magazineList = self.magazineList
    }
}
