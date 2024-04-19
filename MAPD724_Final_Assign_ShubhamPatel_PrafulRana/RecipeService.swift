//
//  RecipeService.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-15.
//

import Foundation

struct RecipeService {
    static let baseURLString = "https://api.spoonacular.com"
        static let apiKey = "c01c9f249753437db74cb30337ca7e37"
    //    static let apiKey = "edc87129618146ff9b361c0b23c0410a"
    //static let apiKey = "fcf1ece5f3454181ab2693ee78d9d480"
    
    static func searchRecipes(search: String, count: Int, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        var components = URLComponents(string: baseURLString)
        components?.path = "/recipes/complexSearch"
        components?.queryItems = [
            URLQueryItem(name: "query", value: search),
            URLQueryItem(name: "number", value: "\(count)"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let searchRecipeResponse = try decoder.decode(SearchRecipeResponse.self, from: data)
                completion(.success(searchRecipeResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func getRandomRecipes(count: Int, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        var components = URLComponents(string: baseURLString)
        components?.path = "/recipes/random"
        components?.queryItems = [
            URLQueryItem(name: "number", value: "\(count)"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            print(String(data: data, encoding: .utf8))
            
            do {
                let decoder = JSONDecoder()
                let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                completion(.success(recipeResponse.recipes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func getRecipeDetails(recipeID: Int, completion: @escaping (Result<Recipe, Error>) -> Void) {
        var components = URLComponents(string: baseURLString)
        components?.path = "/recipes/\(recipeID)/information"
        components?.queryItems = [
            URLQueryItem(name: "includeNutrition", value: "false"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipe = try decoder.decode(Recipe.self, from: data)
                completion(.success(recipe))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func getMultipleRecipeDetails(recipeIDs: [Int], completion: @escaping (Result<[Recipe], Error>) -> Void) {
        let recipeIDsString = recipeIDs.map { String($0) }.joined(separator: ",")
        var components = URLComponents(string: baseURLString)
        components?.path = "/recipes/informationBulk"
        components?.queryItems = [
            URLQueryItem(name: "ids", value: recipeIDsString),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipes = try decoder.decode([Recipe].self, from: data)
                completion(.success(recipes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func searchByIngredients(ingredients: [String], count: Int, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        let joinedIngredients = ingredients.joined(separator: ",")
        var components = URLComponents(string: baseURLString)
        components?.path = "/recipes/findByIngredients"
        components?.queryItems = [
            URLQueryItem(name: "ingredients", value: joinedIngredients),
            URLQueryItem(name: "number", value: "\(count)"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipes = try decoder.decode([Recipe].self, from: data)
                completion(.success(recipes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// MARK: RecipeResponse Model

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

struct SearchRecipeResponse: Codable {
    let results: [Recipe]
}
