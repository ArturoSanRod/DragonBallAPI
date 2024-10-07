//
//  CharacterViewModel.swift
//  ExamenMoviles
//
//  Created by Arturo Sanchez on 07/10/24.
//


import Foundation

class CharacterViewModel: ObservableObject {
    @Published var characters: [CharacterModel] = []
    @Published var planets: [PlanetModel] = [] 
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let fetchCharactersUseCase: FetchCharactersUseCase
    private let planetService = PlanetService()
    private var currentPage = 1
    private var isLastPage = false
    private let limit = 10

    init(fetchCharactersUseCase: FetchCharactersUseCase) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
        fetchPlanets()
    }

    // Cargar personajes
    func fetchCharacters() {
        guard !isLastPage else {
            print("No more characters to load.")
            return
        }

        isLoading = true
        errorMessage = nil
        fetchCharactersUseCase.execute(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let characters):
                    self?.characters.append(contentsOf: characters)
                    self?.currentPage += 1
                    if characters.count < self?.limit ?? 10 {
                        self?.isLastPage = true
                    }

                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // Cargar planetas
    func fetchPlanets() {
        planetService.fetchPlanets { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let planets):
                    self?.planets = planets
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func getPlanetName(for character: CharacterModel) -> String {
        if character.race == "Saiyan" {
            return planets.first(where: { $0.name == "Vegeta" })?.name ?? "Unknown Planet"
        } else if character.race == "Namekian" {
            return planets.first(where: { $0.name == "Namek" })?.name ?? "Unknown Planet"
        } else if character.affiliation.contains("Z Fighter") {
            return planets.first(where: { $0.name == "Tierra" })?.name ?? "Unknown Planet"
        } else if character.race == "Frieza Race" {
                        return planets.first(where: { $0.name == "Freezer No. 79" })?.name ?? "Unknown Planet"
        } else {
            return "Unknown Planet"
        }
    }


}
