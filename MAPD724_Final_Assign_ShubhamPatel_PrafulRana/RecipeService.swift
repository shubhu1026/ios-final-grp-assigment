//
//  RecipeService.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-15.
//

import Foundation

struct RecipeService {
    static let baseURLString = "https://api.spoonacular.com"
    
    static func searchRecipes(search: String, count: Int, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        var components = URLComponents(string: baseURLString)
        components?.path = "/recipes/complexSearch"
        components?.queryItems = [
            URLQueryItem(name: "query", value: search),
            URLQueryItem(name: "number", value: "\(count)"),
            URLQueryItem(name: "apiKey", value: "c01c9f249753437db74cb30337ca7e37")
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
                let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                completion(.success(recipeResponse.recipes))
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
                URLQueryItem(name: "apiKey", value: "c01c9f249753437db74cb30337ca7e37")
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
               // print(String(data: data, encoding: .utf8))

                do {
                    let decoder = JSONDecoder()
                    let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                    completion(.success(recipeResponse.recipes))
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

