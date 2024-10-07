//
//  FetchCharactersUseCase.swift
//  ExamenMoviles
//
//  Created by Arturo Sanchez on 07/10/24.
//


class FetchCharactersUseCase {
    private let repository: CharacterRepositoryProtocol

    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }

    func execute(page: Int, completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        repository.getAllCharacters(page: page, completion: completion)
    }
}
