//
//  Product.swift
//  NextUp
//
//  Created by Szymon Lorenz on 26/9/19.
//  Copyright © 2019 Szymon Lorenz. All rights reserved.
//

import Foundation

enum ProductType {
    case wine
    case beer
    case spirits
    case unknown
}

class Product {
    var id = UUID()
    var name: String = ""
    var description: String = ""
    var type: ProductType = .beer
    var alcohol: Float = 0.5
    var capacity: Int = 250
    var rating: Double = 0
    var price: Double = 6.5
    var image: [URL] = []
    var limit: Int? 
}

extension Product: ObservableObject {}

class ProductList {
    var id: UUID
    var title: String
    var products: [Product]
    
    init(id: UUID = UUID(), title: String, products: [Product]) {
        self.id = id
        self.title = title
        self.products = products
    }
}
