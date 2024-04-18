//
//  ContentView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-15.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var favoriteRecipesViewModel = FavoriteRecipesViewModel()
    
    var body: some View {
        TabView {
            RecipeListView()
                .environmentObject(favoriteRecipesViewModel)
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
            
            FavouriteRecipesView()
                .environmentObject(favoriteRecipesViewModel)
                .tabItem {
                    Label("Favourites", systemImage: "heart.fill")
                }
            
            SearchRecipesView()
                .environmentObject(favoriteRecipesViewModel)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ContentView()
}
