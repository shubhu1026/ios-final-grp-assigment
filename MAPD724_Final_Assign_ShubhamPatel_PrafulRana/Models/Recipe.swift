//
//  Recipe.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-15.
//

import SwiftUI

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
}

struct FavoriteRecipe: Identifiable {
    let id: Int
    let recipe: Recipe
}

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let image: URL
    let imageType: String
    let vegetarian: Bool
    var ingredients: [ExtendedIngredient]? = []
    var instructions: String
    var analyzedInstructions: [AnalyzedInstruction]? = []
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case imageType
        case vegetarian
        case extendedIngredients
        case analyzedInstructions
        case instructions
    }
    
    struct ExtendedIngredient: Codable {
        let name: String
    }
    
    struct AnalyzedInstruction: Codable {
        let name: String
        let steps: [Step]
        
        struct Step: Codable {
            let number: Int
            let step: String
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(URL.self, forKey: .image)
        vegetarian = try container.decode(Bool.self, forKey: .vegetarian)
        imageType = try container.decode(String.self, forKey: .imageType)
        instructions = try container.decode(String.self, forKey: .instructions)
        
        // Decode analyzed instructions
        if let analyzedInstructions = try? container.decode([AnalyzedInstruction].self, forKey: .analyzedInstructions) {
            self.analyzedInstructions = analyzedInstructions
        }
        
        // Decode extended ingredients
        if let extendedIngredients = try? container.decode([ExtendedIngredient].self, forKey: .extendedIngredients) {
            ingredients = extendedIngredients
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(image, forKey: .image)
        try container.encode(imageType, forKey: .imageType)
        try container.encode(instructions, forKey: .instructions)
        try container.encode(ingredients ?? [], forKey: .extendedIngredients)
        try container.encode(analyzedInstructions ?? [], forKey: .analyzedInstructions)
    }
}