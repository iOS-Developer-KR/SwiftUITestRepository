//
//  ProductsView.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/14/24.
//

import SwiftUI
import FirebaseFirestore



struct ProductsView: View {
    @Environment(ProductsViewModel.self) var vm
    var body: some View {
        List {
            ForEach(vm.product) { product in
                ProductCellView(product: product)
                    .contextMenu(menuItems: {
                        Button("Add to favorites") {
                            vm.addUserFavoriteProduct(productId: product.id)
                        }
                    })
                
                if product == vm.product.last {
                    ProgressView()
                        .onAppear {
                            vm.getProducts()
                            print("PROGRESS VIEW APPEARED!!!")
                        }
                }
            }
        }
        .navigationTitle("Products")
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Menu("Filter: \(vm.selectedFilter?.rawValue ?? "NONE")") { // id: \.self로 하면 hashable
                    ForEach(ProductsViewModel.FilterOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try? await vm.filterSelected(option:option)
                            }
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Menu("Filter: \(vm.selectedCategory?.rawValue ?? "NONE")") { // id: \.self로 하면 hashable
                    ForEach(ProductsViewModel.CategoryOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try? await vm.categorySelected(option:option)
                            }
                        }
                    }
                }
            }
        })
        .onAppear {
            vm.getProductsCount()
            vm.getProducts()
        }
    }
}

#Preview {
    NavigationStack {
        ProductsView()
            .environment(ProductsViewModel())
    }
}
