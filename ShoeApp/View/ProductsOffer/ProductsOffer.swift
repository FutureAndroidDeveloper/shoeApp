//
//  ProductsOffer.swift
//  ShoeApp
//
//  Created by Klimenkov, Kirill on 12.05.21.
//

import Foundation

struct ProductsOffer {
    let title: String
    let subtitle: String?
    
    init(title: String, subtitle: String? = nil) {
        self.title = title.uppercased()
        self.subtitle = subtitle
    }
}
