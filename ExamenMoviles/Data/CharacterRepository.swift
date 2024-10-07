//
//  CharacterRepository.swift
//  ExamenMoviles
//
//  Created by Arturo Sanchez on 07/10/24.
//


class CharacterRepository: CharacterRepositoryProtocol {
    let apiService = APIService()

    func getAllCharacters(page: Int, completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        apiService.fetchCharacters(page: page) { result in
            switch result {
            case .success(let characters):
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
