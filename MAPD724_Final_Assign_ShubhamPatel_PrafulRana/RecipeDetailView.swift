//
//  RecipeDetailView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-15.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
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
                
                Text("Ingredients:")
                    .font(.title3)
                    .bold()
                
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(recipe.ingredients ?? [], id: \.name) { ingredient in
                        HStack(alignment: .top, spacing: 5) {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                                .padding(.top, 5)
                            Text(ingredient.name.capitalized)
                                .font(.body)
                        }
                    }
                }
                .padding(.bottom)
                
                Text("Instructions:")
                    .font(.title3)
                    .bold()
                
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(recipe.analyzedInstructions ?? [], id: \.name) { instruction in
                        ForEach(instruction.steps, id: \.number) { step in
                            HStack(alignment: .top, spacing: 5) {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.black)
                                    .font(.system(size: 10))
                                    .padding(.top, 5)
                                Text(step.step)
                                    .font(.body)
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}
