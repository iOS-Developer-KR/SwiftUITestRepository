//
//  FavoriteViewModel.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/14/24.
//

import Foundation
import Combine
import SwiftUI

@MainActor
@Observable final class FavoriteViewModel {
    private(set) var userFavoriteProducts: [UserFavoriteProduct] = []
    private var cancellables = Set<AnyCancellable>()
    
    func addListenerForFavorites() {
        guard let authDataResult = try? AuthenticationManager.shared.getAuthenticatedUser() else { return }
//        UserManager.shared.addListenerForAllUserFavoriteProducts(userId: authDataResult.uid) { [weak self] products in
//            self?.userFavoriteProducts = products
//        }
        UserManager.shared.addListenerForAllUserFavoriteProducts(userId: authDataResult.uid)
            .sink { completion in
                
            } receiveValue: { [weak self] products in
                self?.userFavoriteProducts = products
            }
            .store(in: &cancellables)

    }
    
//    func getFavorites() {
//        Task {
//            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
//            self.userFavoriteProducts = try await UserManager.shared.getAllUserFavoriteProducts(userId: authDataResult.uid)
//
//            var localArray: [(userFavoriteProduct: UserFavoriteProduct, product:Product)] = []
//            for userFavoriteProduct in userFavoriteProducts {
//                if let product = try? await ProductsManager.shared.getProduct(productId: String(userFavoriteProduct.productId)) {
//                    localArray.append((userFavoriteProduct, product))
//                }
//
//            }
//        }
//    }
    
    func removeFromFavorites(favoriteProductId: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.removeUserFavoriteProduct(userId: authDataResult.uid,favoriteProductId: favoriteProductId)
//            getFavorites()
        }
    }
}
