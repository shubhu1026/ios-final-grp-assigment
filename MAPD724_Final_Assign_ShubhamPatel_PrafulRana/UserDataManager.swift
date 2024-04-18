//
//  UserDataManager.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-16.
//

import Foundation

class UserDataManager {
    static let shared = UserDataManager()
    
    private let key = "favoriteRecipeIDs"
    
    func saveFavoriteRecipeIDs(ids: [Int]) {
        UserDefaults.standard.set(ids, forKey: key)
    }
    
    func loadFavoriteRecipeIDs() -> [Int] {
        return UserDefaults.standard.array(forKey: key) as? [Int] ?? []
    }
}
