//
//  RecipeListView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-15.
//

import SwiftUI

struct RecipeListView: View {
    @State private var recipes: [Recipe] = []
    @State private var selectedRecipe: Recipe? = nil // Track the selected recipe
    @Binding var favoriteRecipes: [Recipe]// Track favorite recipes
    
    var body: some View {
        VStack {
            if !recipes.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(recipes) { recipe in
                            RecipeCardView(recipe: recipe, isFavorite: favoriteRecipes.contains(where: { $0.id == recipe.id })) {
                                toggleFavorite(recipe)
                            }
                            .onTapGesture {
                                selectedRecipe = recipe // Set the selected recipe
                            }
                            .gesture(DragGesture()
                                .onEnded { gesture in
                                    if gesture.translation.width < -50 {
                                        addFavorite(recipe)
                                    } else if gesture.translation.width > 50 {
                                        removeFavorite(recipe)
                                    }
                                }
                            )
                        }
                    }
                    .padding()
                }
            } else {
                // Placeholder while loading
                ProgressView()
            }
        }
        .sheet(item: $selectedRecipe) { recipe in
            // Present details of the selected recipe in a modal
            RecipeDetailView(recipe: recipe).padding()
        }
        .onAppear {
            fetchRandomRecipes()
        }
    }
    
    func fetchRandomRecipes() {
        RecipeService.getRandomRecipes(count: 5) { result in
            switch result {
            case .success(let fetchedRecipes):
                DispatchQueue.main.async {
                    self.recipes = fetchedRecipes
                }
            case .failure(let error):
                print("Error fetching random recipes: \(error)")
            }
        }
    }
    
    func toggleFavorite(_ recipe: Recipe) {
        if let index = favoriteRecipes.firstIndex(where: { $0.id == recipe.id }) {
            favoriteRecipes.remove(at: index)
        } else {
            favoriteRecipes.append(recipe)
        }
    }
    
    func addFavorite(_ recipe: Recipe) {
        favoriteRecipes.append(recipe)
    }
    
    func removeFavorite(_ recipe: Recipe) {
        if let index = favoriteRecipes.firstIndex(where: { $0.id == recipe.id }) {
            favoriteRecipes.remove(at: index)
        }
    }
}
