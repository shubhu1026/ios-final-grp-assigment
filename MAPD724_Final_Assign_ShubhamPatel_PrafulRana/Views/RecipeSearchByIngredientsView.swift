//
//  RecipeSearchByIngredientsView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-18.
//

import SwiftUI

struct RecipeSearchByIngredientsView: View {
    @State private var searchText = ""
    @State private var ingredients: [String] = []
    @State private var newIngredient = ""
    @State private var recipes: [Recipe] = []
    @State private var selectedRecipe: Recipe? = nil
    @EnvironmentObject private var favoriteRecipesViewModel: FavoriteRecipesViewModel
    
    var body: some View {
        VStack {
            Text("Discover what you")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color("Onyx"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("can make with")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color("Onyx"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack(alignment: .bottom) {
                Text("your")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(Color("Onyx"))
                Text("Ingredients!")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(Color("Pink"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            HStack {
                TextField("Add Ingredient", text: $newIngredient)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Button(action: addIngredient) {
                    Text("Add")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color("Pink"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            
            ForEach(ingredients, id: \.self) { ingredient in
                HStack {
                    Text(ingredient)
                        .foregroundColor(Color("Onyx"))
                    
                    Spacer()
                    
                    Button(action: { removeIngredient(ingredient) }) {
                        Image(systemName: "minus.circle")
                            .foregroundColor(Color("Pink"))
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            }
            
            Button(action: searchByIngredients) {
                Text("Search")
                    .padding()
                    .background(Color("Pink"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity)
                    .disabled(ingredients.isEmpty || ingredients == [])
            }
            
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(recipes, id: \.id) { recipe in
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
                                
                                Button(action: {
                                    toggleFavorite(recipe)
                                }) {
                                    Image(systemName: favoriteRecipesViewModel.isFavorite(recipeID: recipe.id) ? "heart.fill" : "heart")
                                        .foregroundColor(Color("Pink"))
                                        .font(.system(size: 24))
                                        .padding(8)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .padding(8)
                                        .shadow(radius: 5)
                                }
                                .padding()
                            }
                            
                            // Recipe title
                            Text(recipe.title)
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical)
                        }
                        .background(Color("Pink"))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .onTapGesture(count: 2) {
                            toggleFavorite(recipe)
                        }
                        .onTapGesture {
                            selectedRecipe = recipe
                        }
                    }
                }
                .sheet(item: $selectedRecipe) { recipe in
                    RecipeDetailView(recipe: recipe)
                }
            }
            
            Spacer()
        }
    }
    
    private func addIngredient() {
        guard !newIngredient.isEmpty else { return }
        ingredients.append(newIngredient)
        newIngredient = ""
    }
    
    private func removeIngredient(_ ingredient: String) {
        if let index = ingredients.firstIndex(of: ingredient) {
            ingredients.remove(at: index)
        }
    }
    
    private func toggleFavorite(_ recipe: Recipe) {
        if favoriteRecipesViewModel.isFavorite(recipeID: recipe.id) {
            favoriteRecipesViewModel.removeFav(recipeID: recipe.id)
        } else {
            favoriteRecipesViewModel.addFav(recipeID: recipe.id)
        }
    }
    
    private func searchByIngredients() {
        let ingredientsQuery = ingredients.joined(separator: ",")
        RecipeService.searchRecipes(search: ingredientsQuery, count: 10) { result in
            switch result {
            case .success(let recipes):
                self.recipes = recipes
            case .failure(let error):
                print("Error searching recipes: \(error)")
            }
        }
    }
}

struct RecipeSearchByIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSearchByIngredientsView()
    }
}
