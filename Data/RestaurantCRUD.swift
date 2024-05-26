//
//  restaurantArray.swift
//  RestaurantPractice
//
//  Created by 유철원 on 5/25/24.
//

import Foundation

struct RestaurantCRUD {
    
    private var restaurantArray: [Restaurant]
    private var searchedArray: [Restaurant]
    private var likedArray: [Restaurant]

    private var searchedWordList: [String]
    private var likedIndexList: [Int]
    
    private var isLikeResult: Bool
    private var isSearchResult: Bool
    
    
    init() {
        if let list = UserDefaultsManager.restaurantList {
            restaurantArray = list
        } else {
            restaurantArray = RestaurantList().restaurantArray
            UserDefaultsManager.restaurantList = self.restaurantArray
        }
        
        if let list = UserDefaultsManager.searchedRestaurantList {
            searchedArray = list
        } else {
            searchedArray = []
        }
        
        if let list = UserDefaultsManager.likedRestaurantList {
            likedArray = list
        } else {
            likedArray = []
        }
        
        if let list = UserDefaults.standard.array(forKey: "likedIndexList") {
            likedIndexList = list as! [Int]
        } else {
            likedIndexList = []
        }
        
        if let list = UserDefaults.standard.array(forKey: "searchedWordList") {
            searchedWordList = list as! [String]
        } else {
            searchedWordList = []
        }
        
        isSearchResult = UserDefaults.standard.bool(forKey: "isSearchResult")
        print("loaded_isSearchResult: \(isSearchResult)")
        isLikeResult = UserDefaults.standard.bool(forKey: "isLikedResult")
    
        print("searchedWordList: \(searchedWordList)")
        print("searchedArray: \(searchedArray.count)")
        print("restaurantArray: \(restaurantArray.count)")
        
        
    }
    
    func getCount() -> Int{
        return restaurantArray.count
    }
    
    func getSearchedCount() -> Int {
        return searchedArray.count
    }
    
    func getLikedCount() -> Int {
        return likedArray.count
    }
    
    func getrestaurantArray() -> [Restaurant] {
        return restaurantArray
    }
    
    func getRestaurant(at index: Int) -> Restaurant {
        return restaurantArray[index]
    }
    
    func getSearchedRestaurant(at index: Int) -> Restaurant {
        return searchedArray[index]
    }
    
    func getLikedRestaurant(at index: Int) -> Restaurant {
        return likedArray[index]
    }
    
    func getIsSearchResult() -> Bool{
        return isSearchResult
    }
    
    func getIsLikeResult() -> Bool{
        return isLikeResult
    }
    
    mutating func clearSearchedArray() {
        searchedArray.removeAll()
    }
    
    mutating func setSearchedArray(word: String) {
        print("searchWord: \(word)")
        for restaurant in restaurantArray {
            if restaurant.category.contains(word) {
                appendSearchArray(restaurant)
                continue
            }
            if restaurant.name.contains(word) {
                appendSearchArray(restaurant)
                continue
            }
            if restaurant.address.contains(word) {
                appendSearchArray(restaurant)
                continue
            }
            if restaurant.phoneNumber.contains(word) {
                appendSearchArray(restaurant)
                continue
            }
//            if String(restaurant.price).contains(word) {
//                appendSearchArray(restaurant)
//                continue
//            }
        }
            
        if let oldList = UserDefaults.standard.array(forKey: "searchedWordList") as! [String]?,
           searchedWordList.count > oldList.count  {
           UserDefaults.standard.set(searchedWordList, forKey: "searchedWordList")
        }
            
        UserDefaultsManager.searchedRestaurantList = searchedArray
        print("searchedArray: \(searchedArray)")
        print("searchedWordList: \(searchedWordList)")
    }
        
    mutating func appendSearchArray(_ restaurant: Restaurant) {
        searchedArray.append(restaurant)
    }
    
    mutating func clearSearchArray() {
        searchedArray.removeAll()
    }
    
    mutating func clearLikedArray() {
        likedArray.removeAll()
    }
    
    mutating func setLikedArray() {
        for restaurant in restaurantArray {
            if restaurant.like {
                likedArray.append(restaurant)
            }
        }
    }
    
    mutating func append(_ restaurant: Restaurant) {
        self.restaurantArray.append(restaurant)
        UserDefaultsManager.restaurantList = self.restaurantArray
    }
    
    mutating func delete(at index: Int) {
        self.restaurantArray.remove(at: index)
        UserDefaultsManager.restaurantList = self.restaurantArray
    }
    
    mutating func update(at index: Int, _ restaurant: Restaurant) {
        self.restaurantArray[index] = restaurant
        UserDefaultsManager.restaurantList = self.restaurantArray
    }
    
    mutating func updateLike(at index: Int) {
        self.restaurantArray[index].like.toggle()
        UserDefaultsManager.restaurantList = self.restaurantArray
    }
    
    mutating func updateIsSearchResult() {
        self.isSearchResult.toggle()
        UserDefaults.standard.set(self.isSearchResult, forKey: "isSearchResult")
    }
    
    mutating func updateIsLikeResult() {
        self.isLikeResult.toggle()
        UserDefaults.standard.set(self.isLikeResult, forKey: "isLikedResult")
    }
}
