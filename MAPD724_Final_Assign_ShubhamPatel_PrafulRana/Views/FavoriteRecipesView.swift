//
//  FavoriteRecipesView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-15.
//

// FavouriteRecipesView.swift

import SwiftUI

struct FavoriteRecipesView: View {
    @EnvironmentObject private var favoriteRecipesViewModel: FavoriteRecipesViewModel
    @State private var selectedRecipe: Recipe? = nil
    @State private var favoriteRecipes: [Recipe] = []
    @State private var favoriteRecipeIDs: [Int] = []
    
    var body: some View {
        VStack {
            if !favoriteRecipes.isEmpty {
                VStack{
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 20) {
                            ForEach(favoriteRecipes) { recipe in
                                VStack(alignment: .leading) {
                                    // Image with rounded corners only on top
                                    
                                    ZStack(alignment: .topTrailing){
                                        AsyncImage(url: recipe.image) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 200)
                                                .clipped()
                                        } placeholder: {
                                            // Placeholder while loading
                                            ProgressView()
                                        }
                                        .overlay(Color.black.opacity(0.3))
                                        
                                        Button(action: { toggleFavorite(recipe) }) {
                                            Image(systemName: "heart.fill")
                                                .foregroundColor(Color("Pink"))
                                                .font(.system(size: 24))
                                                .padding(8)
                                                .background(Color.white)
                                                .clipShape(Circle())
                                                .padding(8)
                                                .shadow(radius: 5)
                                        }
                                    }
                                    
                                    // Recipe title
                                    Text(recipe.title)
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.bottom)
                                    
                                    HStack{
                                        Image(systemName: "fork.knife.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.title)
                                        
                                        Text("\(recipe.servings ?? 1) servings")
                                            .font(.body)
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                    .padding(.horizontal)
                                    .padding(.top)
                                    .padding(.bottom, 4)
                                    
                                    HStack{
                                        Image(systemName: "clock.fill")
                                            .foregroundColor(.white)
                                            .font(.title)
                                        
                                        Text("Ready in \(recipe.readyInMinutes ?? -1) mins")
                                            .font(.body)
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                    .padding(.horizontal)
                                    .padding(.bottom)
                                }
                                .background(Color("Pink"))
                                .cornerRadius(10) // Ensure rounded corners for the card
                                .shadow(radius: 5)
                                .padding(4)
                                .onTapGesture(count: 2) {
                                    toggleFavorite(recipe)
                                }
                                .onTapGesture {
                                    selectedRecipe = recipe
                                }
                            }
                        }
                    }
                }
            } else {
                Text("No favorite recipes")
                    .padding()
            }
        }
        .padding()
        .sheet(item: $selectedRecipe) { recipe in
            RecipeDetailView(recipe: recipe).padding()
        }
        .onAppear {
            favoriteRecipeIDs = favoriteRecipesViewModel.favoriteRecipeIDs
            
            // Call the function to get details of multiple recipes
            RecipeService.getMultipleRecipeDetails(recipeIDs: favoriteRecipeIDs) { result in
                switch result {
                case .success(let recipes):
                    DispatchQueue.main.async {
                        self.favoriteRecipes = recipes
                    }
                case .failure(let error):
                    print("Error fetching favorite recipes: \(error)")
                }
            }
        }
    }
    
    private func toggleFavorite(_ recipe: Recipe) {
        if let index = favoriteRecipes.firstIndex(where: { $0.id == recipe.id }) {
            favoriteRecipes.remove(at: index)
            favoriteRecipesViewModel.toggleFavorite(recipeID: recipe.id)
        }
    }
    
}

