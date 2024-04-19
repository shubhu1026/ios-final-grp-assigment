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
            HomeView()
                .environmentObject(favoriteRecipesViewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            RecipeSearchByIngredientsView()
                .environmentObject(favoriteRecipesViewModel)
                .tabItem {
                    Label("Recipe Search", systemImage: "book")
                }
            
            FavoriteRecipesView()
                .environmentObject(favoriteRecipesViewModel)
                .tabItem {
                    Label("Favourites", systemImage: "heart.fill")
                }
        }
        .accentColor(Color("Pink"))
    }
}

#Preview {
    ContentView()
}
