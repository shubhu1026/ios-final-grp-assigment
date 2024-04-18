//
//  RecipeMinimalDetailsView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-16.
//

import SwiftUI

struct RecipeMinimalDetailsView: View {
    var recipe: Recipe
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                // Load image from URL
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
                
                Text(recipe.title)
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
            }
        }
    }
}
