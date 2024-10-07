//
//  CharacterListView.swift
//  ExamenMoviles
//
//  Created by Arturo Sanchez on 07/10/24.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject var viewModel = CharacterViewModel(fetchCharactersUseCase: FetchCharactersUseCase(repository: CharacterRepository()))
    
    @State private var selectedRace: String = "Todos"
    
    let races = ["Todos", "Saiyan", "Namekian", "Frieza Race", "Human"]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Selecciona Raza", selection: $selectedRace) {
                    ForEach(races, id: \.self) { race in
                        Text(race).tag(race)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                if viewModel.isLoading {
                    ProgressView("Cargando Personajes...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)").foregroundColor(.red)
                } else {
                    List(filteredCharacters) { character in
                        CharacterCardView(character: character, planet: viewModel.getPlanetName(for: character))
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("Personajes")
                    .onAppear {
                        viewModel.fetchCharacters()
                    }
                }
            }
        }
    }
    
    var filteredCharacters: [CharacterModel] {
        if selectedRace == "Todos" {
            return viewModel.characters
        } else {
            return viewModel.characters.filter { $0.race == selectedRace }
        }
    }
}
