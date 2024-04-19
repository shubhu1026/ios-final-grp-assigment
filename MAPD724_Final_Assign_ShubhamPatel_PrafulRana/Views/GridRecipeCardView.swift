//
//  HorizontalRecipeCardView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-18.
//

import SwiftUI

struct GridRecipeCardView: View {
    let recipe: Recipe
    let isFavorite: Bool
    let toggleFavorite: () -> Void
    
    var body: some View {
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
                
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
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
        .shadow(radius: 5) // Add shadow to the card
    }
}
