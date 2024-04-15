//
//  ContentView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-15.
//

import SwiftUI

struct ContentView: View {
    @State private var favoriteRecipes: [Recipe] = []
    
    var body: some View {
        TabView {
            RecipeListView(favoriteRecipes: $favoriteRecipes)
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
            
            FavouriteRecipesView(favoriteRecipes: $favoriteRecipes)
                .tabItem {
                    Label("Favourites", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
