//
//  FavouriteRecipesView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-15.
//

import SwiftUI

struct FavouriteRecipesView: View {
    @Binding var favoriteRecipes: [Recipe]
    @State private var selectedRecipe: Recipe? = nil // Track the selected recipe
    
    var body: some View {
        VStack {
            if !favoriteRecipes.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(favoriteRecipes) { recipe in
                            VStack(alignment: .leading) {
                                AsyncImage(url: recipe.image) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(10)
                                } placeholder: {
                                    // Placeholder while loading
                                    ProgressView()
                                }
                                .cornerRadius(10)
                                
                                HStack {
                                    //                Image(systemName: "circle.fill")
                                    //                    .foregroundColor(recipe.vegetarian ? .green : .red)
                                    //                    .font(.system(size: 20))
                                    Text(recipe.title)
                                        .font(.headline)
                                    Spacer()
                                    Button(action: {
                                        toggleFavorite(recipe)
                                    }) {
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.red)
                                            .font(.system(size: 24))
                                            .padding()
                                    }
                                    
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                    .padding()
                }
            } else {
                Text("No favorite recipes")
                    .padding()
            }
        }
        .sheet(item: $selectedRecipe) { recipe in
            RecipeDetailView(recipe: recipe).padding()
        }
    }
    
    private func toggleFavorite(_ recipe: Recipe) {
        if let index = favoriteRecipes.firstIndex(where: { $0.id == recipe.id }) {
            favoriteRecipes.remove(at: index)
        }
    }
}
