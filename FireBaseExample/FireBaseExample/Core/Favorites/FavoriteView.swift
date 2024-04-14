//
//  FavoriteView.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/14/24.
//

import SwiftUI
import Combine



struct FavoriteView: View {
    @Environment(FavoriteViewModel.self) var vm
    
    var body: some View {
        List {
            ForEach(vm.userFavoriteProducts, id: \.id.self) { item in
                ProductCellViewBuilder(productId: String(item.productId))
                    .contextMenu {
                        Button("Remove to favorites") {
                            vm.removeFromFavorites(favoriteProductId: item.id)
                        }
                    }
            }
        }
        .navigationTitle("Favorites")
        .onFirstAppear {
            vm.addListenerForFavorites()
        }
    }
}

#Preview {
    NavigationStack {
        FavoriteView()
            .environment(FavoriteViewModel())
    }
}

//struct OnFirstAppearViewModifier: ViewModifier {
//    @State private var didAppear: Bool = false
//    let perform: (() -> Void)?
//    
//    func body(content: Content) -> some View {
//        content
//            .onAppear {
//                if !didAppear {
//                    perform?()
//                    didAppear = true
//                }
//            }
//    }
//}

//extension View {
//    func onFirstAppear(perform: (() -> Void)?) -> some View {
//        modifier(OnFirstAppearViewModifier(perform: perform))
//    }
//}
