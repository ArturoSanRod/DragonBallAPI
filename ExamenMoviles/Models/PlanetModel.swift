//
//  PlanetModel.swift
//  ExamenMoviles
//
//  Created by Arturo Sanchez on 07/10/24.
//

import Foundation

struct PlanetResponse: Decodable {
    let items: [PlanetModel]
    let meta: Meta
    let links: Links
}

struct PlanetModel: Identifiable, Decodable {
    let id: Int
    let name: String
    let isDestroyed: Bool
    let description: String
    let image: String
}

struct Meta: Decodable {
    let totalItems: Int
    let itemCount: Int
    let itemsPerPage: Int
    let totalPages: Int
    let currentPage: Int
}

struct Links: Decodable {
    let first: String
    let previous: String?
    let next: String?
    let last: String
}
