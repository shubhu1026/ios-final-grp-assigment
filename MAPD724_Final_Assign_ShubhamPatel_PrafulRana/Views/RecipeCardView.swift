//
//  RecipeCardView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-15.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe
    let isFavorite: Bool
    let toggleFavorite: () -> Void // Action to toggle favorite
    
    var body: some View {
        VStack(alignment: .leading) {
            // Load image from URL
            ZStack(alignment: .topTrailing) {
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
                .overlay(Color.black.opacity(0.3))
                
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                        .font(.system(size: 24))
                        .padding(8)
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding(8)
                        .shadow(radius: 5)
                }
            }
            
            HStack(alignment: .top) {
                Text(recipe.title)
                    .font(.headline)
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
