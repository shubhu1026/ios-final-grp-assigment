//
//  FavoriteRecipesViewModel.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-16.
//

import SwiftUI

class FavoriteRecipesViewModel: ObservableObject {
    @Published var favoriteRecipeIDs: [Int] {
        didSet {
            UserDataManager.shared.saveFavoriteRecipeIDs(ids: favoriteRecipeIDs)
        }
    }
    
    init() {
        favoriteRecipeIDs = UserDataManager.shared.loadFavoriteRecipeIDs()
    }
    
    func toggleFavorite(recipeID: Int) {
        if favoriteRecipeIDs.contains(recipeID) {
            removeFav(recipeID: recipeID)
        } else {
            addFav(recipeID: recipeID)
        }
    }
    
    func isFavorite(recipeID: Int) -> Bool {
        return favoriteRecipeIDs.contains(recipeID)
    }
    
    func addFav(recipeID: Int) {
        favoriteRecipeIDs.append(recipeID)
    }
    
    func removeFav(recipeID: Int) {
        if let index = favoriteRecipeIDs.firstIndex(of: recipeID) {
            favoriteRecipeIDs.remove(at: index)
        }
    }
}
