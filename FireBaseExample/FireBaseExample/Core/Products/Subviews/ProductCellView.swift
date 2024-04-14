//
//  ProductCellView.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/14/24.
//

import SwiftUI

struct ProductCellView: View {
    
    let product: Product
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: product.thumbnail ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75, height: 75)
            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
            
            VStack(alignment: .leading) {
                Text(product.title ?? "n/a")
                Text("Price: $" + String(product.price ?? 0))
                Text("Rating: " + String(product.rating ?? 0))
                Text("Category: " + (product.category ?? "n/a"))
                Text("Brand: " + (product.brand ?? "n/a"))
            }
            .font(.callout)
            .foregroundStyle(.secondary)
        }
        

    }
}

#Preview {
    ProductCellView(product: Product(id: 1, title: "test", description: "test", price: 0.0, discountPercentage: 0.0, rating: 0.0, stock: 1, brand: "test", category: "test", thumbnail: "test", images: [""]))
}
