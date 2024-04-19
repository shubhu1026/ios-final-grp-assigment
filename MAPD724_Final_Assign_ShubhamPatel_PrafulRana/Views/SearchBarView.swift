//
//  SearchBarView.swift
//  MAPD724_Final_Assign_ShubhamPatel_PrafulRana
//
//  Created by Shubham Patel on 2024-04-18.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearchButtonClicked: (String) -> Void
    
    var body: some View {
        HStack {
            TextField("Search for recipe", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            Button(action: {
                onSearchButtonClicked(text)
            }) {
                Text("Search")
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color("Pink"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}
