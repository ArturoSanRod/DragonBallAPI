//
//  CharacterViewModel.swift
//  ExamenMoviles
//
//  Created by Arturo Sanchez on 07/10/24.
//


import Foundation

class CharacterViewModel: ObservableObject {
    @Published var characters: [CharacterModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let fetchCharactersUseCase: FetchCharactersUseCase
    private var currentPage = 1
    private var isLastPage = false 
    private let limit = 10

    init(fetchCharactersUseCase: FetchCharactersUseCase) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
    }

    func fetchCharacters() {
        guard !isLastPage else {
            print("No exiten mas personajes.")
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
                    print("Personajes encontrados: \(self?.characters.count ?? 0)")

                    
                    if characters.count < self?.limit ?? 10 {
                        self?.isLastPage = true
                        print("Ultima página.")
                    }

                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
