//
//  RecipeDetailView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-15.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @State private var loadedDetails: Bool = false
    @State private var detailedRecipe: Recipe? = nil
    @EnvironmentObject private var favoriteRecipesViewModel: FavoriteRecipesViewModel
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                if let detailedRecipe = detailedRecipe {
                    // Load detailed recipe information
                    loadDetailedRecipe(recipe: detailedRecipe)
                } else {
                    // Placeholder while loading
                    ProgressView()
                }
            }
            .onAppear {
                // Fetch recipe details if not already loaded
                if !loadedDetails {
                    RecipeService.getRecipeDetails(recipeID: recipe.id) { result in
                        switch result {
                        case .success(let detailedRecipe):
                            self.detailedRecipe = detailedRecipe
                            loadedDetails = true
                        case .failure(let error):
                            print("Error fetching recipe details: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    private func loadDetailedRecipe(recipe: Recipe) -> some View {
        // Display detailed recipe information
        VStack(alignment: .leading) {
            // Load image from URL
            AsyncImage(url: recipe.image) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .clipped()
            } placeholder: {
                // Placeholder while loading
                ProgressView()
            }
            
            HStack{
                Spacer()
                Button(action: {toggleFavorite(recipe)}) {
                    Image(systemName: isFavorite(recipe) ? "heart.fill" : "heart")
                        .foregroundColor(Color("Pink"))
                        .font(.system(size: 24))
                        .padding(8)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
            }
            .offset(y: -60)
            .padding(.horizontal)
            
            Text(recipe.title)
                .font(.title)
                .bold()
                .foregroundColor(Color("Pink"))
                .padding(.horizontal)
                .padding(.bottom)
            
            HStack{
                Image(systemName: "fork.knife.circle.fill")
                    .foregroundColor(Color("Pink"))
                    .font(.title)
                
                Text("\(recipe.servings ?? 1) servings")
                    .font(.body)
                    .bold()
                    .foregroundColor(Color("Onyx"))
            }
            .padding(.horizontal)
            .padding(.bottom, 4)
            
            HStack{
                Image(systemName: "clock.fill")
                    .foregroundColor(Color("Pink"))
                    .font(.title)
                
                Text("Ready in \(recipe.readyInMinutes ?? -1) mins")
                    .font(.body)
                    .bold()
                    .foregroundColor(Color("Onyx"))
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            
            Text("Dietary Preference:")
                .font(.title3)
                .bold()
                .foregroundColor(Color("Pink"))
                .padding(.horizontal)
            
            HStack {
                Image(recipe.vegetarian ?? true ? "veg" : "nonveg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                Text(recipe.vegetarian ?? true ? "Vegetarian" : "Non-Vegetarian")
                    .font(.body)
                    .foregroundColor(Color("Onyx"))
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Text("Ingredients:")
                .font(.title3)
                .bold()
                .foregroundColor(Color("Pink"))
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(recipe.ingredients ?? [], id: \.name) { ingredient in
                    HStack(alignment: .top, spacing: 5) {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Color("Pink"))
                            .font(.system(size: 10))
                            .padding(.top, 5)
                        Text(ingredient.name.capitalized)
                            .font(.body)
                            .foregroundColor(Color("Onyx"))
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Text("Instructions:")
                .font(.title3)
                .bold()
                .foregroundColor(Color("Pink"))
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(recipe.analyzedInstructions ?? [], id: \.name) { instruction in
                    ForEach(instruction.steps, id: \.number) { step in
                        HStack(alignment: .top, spacing: 5) {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color("Pink"))
                                .font(.system(size: 10))
                                .padding(.top, 5)
                            Text(step.step)
                                .font(.body)
                                .foregroundColor(Color("Onyx"))
                        }
                    }
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
    
    private func toggleFavorite(_ recipe: Recipe) {
        favoriteRecipesViewModel.toggleFavorite(recipeID: recipe.id)
    }
    
    private func isFavorite(_ recipe: Recipe) -> Bool {
        return favoriteRecipesViewModel.isFavorite(recipeID: recipe.id)
    }
}
