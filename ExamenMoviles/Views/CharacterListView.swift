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
            if viewModel.isLoading {
                ProgressView("Cargando Personajes...")
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
                    }
                }
                .navigationTitle("Personajes")
                .onAppear {
                    viewModel.fetchCharacters()
                }
            }
        }
    }
}
