//
//  ProductsView.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/14/24.
//

import SwiftUI

@MainActor
@Observable final class ProductsViewModel {
    
    private(set) var product: [Product] = []
    
    func getAllProducts() async throws {
        self.product = try await ProductsManager.shared.getAllProducts()
    }
}

struct ProductsView: View {
    @Environment(ProductsViewModel.self) var vm
    var body: some View {
        List {
            ForEach(vm.product) { product in
                ProductCellView(product: product)
            }
        }
        .navigationTitle("Products")
        .onAppear {
            Task {
                try? await vm.getAllProducts()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProductsView()
            .environment(ProductsViewModel())
    }
}
