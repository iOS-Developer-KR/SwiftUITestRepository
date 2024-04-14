//
//  ProductsManager.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/14/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


final class ProductsManager {
    
    static let shared = ProductsManager()
    private init() { }
    
    private let productsCollection = Firestore.firestore().collection("products")
    
    private func productDocument(productId: String) -> DocumentReference {
        productsCollection.document(productId)
    }
    
    func uploadProduct(product: Product) async throws {
        try productDocument(productId: String(product.id)).setData(from: product, merge: false)
    }
    
    func getProduct(productId: String) async throws -> Product {
        try await productDocument(productId: productId).getDocument(as: Product.self)
    }
    
    func getAllProducts() async throws -> [Product] {
        try await productsCollection.getDocuments(as: Product.self)
    }
    
}

extension Query {
    
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T : Decodable {
        let snapshot = try await self.getDocuments()
        
        return try snapshot.documents.map ({ document in
            try document.data(as: T.self) // T는 codable을 준수하지 않는다 실제로 Codable이 가능한데 컴퓨터는 모른다.
        })
    }
}
