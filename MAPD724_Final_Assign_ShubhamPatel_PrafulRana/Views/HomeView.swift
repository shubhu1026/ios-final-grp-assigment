//
//  HomeView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-18.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedRecipe: Recipe? = nil
    @State private var searchResults: [Recipe] = []
    
    @EnvironmentObject private var favoriteRecipesViewModel: FavoriteRecipesViewModel
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom){
                Image(systemName: "person.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color("Pink"))
                Text("Hello, User!")
                    .font(.title2)
                    .foregroundColor(.gray)
                Spacer()
            }
            
            Text("Discover Your")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color("Onyx"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .bottom){
                Text("Favourite")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(Color("Onyx"))
                Text("Recipe!")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(Color("Pink"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            SearchBar(text: $searchText, onSearchButtonClicked: searchRecipes)
            
            HStack(alignment: .bottom){
                Text("Recipes for you")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(Color("Onyx"))
                
                //                Image(systemName: "trophy.fill")
                //                    .font(.largeTitle)
                //                    .foregroundColor(Color("Pink"))
                //
                Spacer()
                
                Button(action: {
                    getRandomRecipes() // Call getRandomRecipes() when refresh button is clicked
                }) {
                    Image(systemName: "arrow.clockwise.circle")
                        .font(.largeTitle)
                        .foregroundColor(Color("Pink"))
                }
                
            }
            .padding(.top)
            
            ScrollView(showsIndicators: false){
                if !searchResults.isEmpty {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
                        ForEach(searchResults) { recipe in
                            GridRecipeCardView(recipe: recipe, isFavorite: isFavorite(recipe)) {
                                toggleFavorite(recipe)
                            }
                            .padding(4)
                            .onTapGesture(count: 2) {
                                toggleFavorite(recipe)
                            }
                            .onTapGesture {
                                selectedRecipe = recipe
                            }
                        }
                    }
                }else {
                    // Placeholder while loading
                    ProgressView()
                }
            }
        }
        .padding()
        .sheet(item: $selectedRecipe) { recipe in
                RecipeDetailView(recipe: recipe)
        }
        .onAppear {
            getRandomRecipes()
        }
    }
    
    func searchRecipes(searchTerm: String) {
        guard !searchTerm.isEmpty else { return }
        RecipeService.searchRecipes(search: searchTerm, count: 10) { result in
            switch result {
            case .success(let searchResults):
                DispatchQueue.main.async {
                    self.searchResults = searchResults
                }
            case .failure(let error):
                print("Error searching 2 recipes: \(error)")
            }
        }
    }
    
    func getRandomRecipes() {
        self.searchResults = []
        RecipeService.getRandomRecipes(count: 10){ result in
            switch result {
            case .success(let searchResults):
                DispatchQueue.main.async {
                    self.searchResults = searchResults
                }
            case .failure(let error):
                print("Error getting random recipes: \(error)")
            }
        }
    }
    
    func addFavorite(_ recipe: Recipe) {
        favoriteRecipesViewModel.addFav(recipeID: recipe.id)
    }
    
    func removeFavorite(_ recipe: Recipe) {
        favoriteRecipesViewModel.removeFav(recipeID: recipe.id)
    }
    
    private func toggleFavorite(_ recipe: Recipe) {
        favoriteRecipesViewModel.toggleFavorite(recipeID: recipe.id)
    }
    
    private func isFavorite(_ recipe: Recipe) -> Bool {
        return favoriteRecipesViewModel.isFavorite(recipeID: recipe.id)
    }
}

#Preview {
    HomeView()
}
