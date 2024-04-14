//
//  Utilties.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/14/24.
//

import Foundation



struct ProductArray: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

struct Product: Identifiable, Codable {
    let id: Int
    let title: String?
    let description: String?
    let price: Double?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
}

//    func downloadProductsAndUploadToFirebase() {
//
//        guard let url = URL(string: "https://dummyjson.com/products") else { return }
//
//        Task {
//            do {
//                let (data, _) = try await URLSession.shared.data(from: url)
//                let products = try JSONDecoder().decode(ProductArray.self, from: data)
//                let productArray = products.products
//
//                for product in productArray {
//                    try? await ProductsManager.shared.uploadProduct(product: product)
//                }
//
//                print("SUCCESS")
//                print(products.products.count)
//            } catch {
//                print(error)
//            }
//        }
//    }
