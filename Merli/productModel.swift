//
//  productModel.swift
//  Merli
//
//  Created by Jésica González Baqué on 08/06/2021.
//

import Foundation

// Estructura para cargar los valores que vienen en el JSON

// Cada producto
struct Product: Codable
{
    var title: String
    var thumbnail: String
    var price: Double
}

// El arrego de productos
struct Products: Codable {
    var results: [Product]
}
