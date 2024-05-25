//
//  restaurantArray.swift
//  RestaurantPractice
//
//  Created by 유철원 on 5/25/24.
//

import Foundation

struct RestaurantCRUD {
    
    private var restaurantArray: [Restaurant]
    
    
    init() {
        if let list = UserDefaultsManager.restaurantList {
            restaurantArray = list
        } else {
            restaurantArray = RestaurantList().restaurantArray
            UserDefaultsManager.restaurantList = self.restaurantArray
        }
        
        print(restaurantArray.count)
        print(restaurantArray)
    }
    
    func getCount() -> Int{
        return restaurantArray.count
    }
    
    func getrestaurantArray() -> [Restaurant] {
        return restaurantArray
    }
    
    func getRestaurant(at index: Int) -> Restaurant {
        return restaurantArray[index]
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
    
    

    
}
