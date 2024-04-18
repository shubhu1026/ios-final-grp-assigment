//
//  SearchRecipesView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-16.
//

import SwiftUI

struct SearchRecipesView: View {
    @State private var searchText = ""
    @State private var searchResults: [Recipe] = []
    
    @EnvironmentObject private var favoriteRecipesViewModel: FavoriteRecipesViewModel
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, onSearchButtonClicked: searchRecipes)
            
            if !searchResults.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(searchResults) { recipe in
                            RecipeCardView(recipe: recipe, isFavorite: isFavorite(recipe)) {
                                addToFavorites(recipe)
                            }
                        }
                    }
                    .padding()
                }
            } else {
                Text("No search results")
                    .padding()
            }
            
            Spacer()
        }
    }
    
    func searchRecipes() {
        guard !searchText.isEmpty else { return }
        RecipeService.searchRecipes(search: searchText, count: 10) { result in
            switch result {
            case .success(let searchResults):
                DispatchQueue.main.async {
                    self.searchResults = searchResults
                }
            case .failure(let error):
                print("Error searching recipes: \(error)")
            }
        }
    }
    
    func isFavorite(_ recipe: Recipe) -> Bool { // Function to check if recipe is favorite
        return favoriteRecipesViewModel.isFavorite(recipeID: recipe.id)
    }
    
    func addToFavorites(_ recipe: Recipe) {
        favoriteRecipesViewModel.toggleFavorite(recipeID: recipe.id)
    }
}

struct SearchBar: View {
    @Binding var text: String
    var onSearchButtonClicked: () -> Void
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            Button(action: {
                onSearchButtonClicked()
            }) {
                Text("Search")
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
