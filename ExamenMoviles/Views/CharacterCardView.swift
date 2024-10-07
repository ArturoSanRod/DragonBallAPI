//
//  CharacterCardView.swift
//  ExamenMoviles
//
//  Created by Arturo Sanchez on 07/10/24.
//


import SwiftUI

struct CharacterCardView: View {
    let character: CharacterModel
    let planet: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit) 
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.orange, lineWidth: 2))
                        .shadow(radius: 5)
                } placeholder: {
                    ProgressView()
                }

                
                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                    Text("Ki: \(character.ki)")
                        .font(.subheadline)
                    Text("Max Ki: \(character.maxKi)")
                        .font(.subheadline)
                }
                Spacer()
            }
            .padding()
            
            Text("Affiliación: \(character.affiliation)")
                .font(.body)
                .foregroundColor(.gray)
            
            Text("Planeta: \(planet)")
                .font(.body)
                .foregroundColor(.blue)
            
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .shadow(color: .gray, radius: 5, x: 0, y: 5)
        .padding([.top, .horizontal])
    }
}
