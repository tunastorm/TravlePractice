//
//  UserDefaultManager.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit



struct UserDefaultsManager {
    @UserDefaultWrapper(key: "magazineList", defaultValue: nil)
    static var magazineList: [Magazine]?
    
    @UserDefaultWrapper(key: "retaurantList", defaultValue: nil)
    static var restaurantList: [Restaurant]?
    
    @UserDefaultWrapper(key: "searchedRetaurantList", defaultValue: nil)
    static var searchedRestaurantList: [Restaurant]?
    
    @UserDefaultWrapper(key: "likedRetaurantList", defaultValue: nil)
    static var likedRestaurantList: [Restaurant]?
    
    @UserDefaultWrapper(key: "sectionList", defaultValue: nil)
    static var sectionList: [Section]?
}


@propertyWrapper
struct UserDefaultWrapper<T: Codable> {
    private let key: String
    private let defaultValue: T?
    
    init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T? {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let lodedObejct = try? decoder.decode(T.self, from: savedData) {
                    return lodedObejct
                }
            }
            return defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.setValue(encoded, forKey: key)
            }
        }
    }
}
