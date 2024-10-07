//
//  CharacterListView.swift
//  ExamenMoviles
//
//  Created by Arturo Sanchez on 07/10/24.
//


import SwiftUI

struct CharacterListView: View {
    @StateObject var viewModel = CharacterViewModel(fetchCharactersUseCase: FetchCharactersUseCase(repository: CharacterRepository()))

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading characters...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)").foregroundColor(.red)
                } else {
                    List(viewModel.characters) { character in
                        VStack(alignment: .leading) {
                            HStack {
                                AsyncImage(url: URL(string: character.image)) { image in
                                    image.resizable().scaledToFit().frame(width: 50, height: 50)
                                } placeholder: {
                                    ProgressView()
                                }
                                Text(character.name).font(.headline)
                            }
                            Text("Ki: \(character.ki)")
                            Text("Max Ki: \(character.maxKi)")
                            Text("Affiliation: \(character.affiliation)")
                            // Mostrar el planeta del personaje
                            Text("Planet: \(viewModel.getPlanetName(for: character))")
                        }
                    }
                    .navigationTitle("Characters")
                    .onAppear {
                        viewModel.fetchCharacters()
                    }
                }
            }
        }
    }
}
