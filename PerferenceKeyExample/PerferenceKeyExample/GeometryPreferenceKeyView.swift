//
//  GeometryPreferenceKeyView.swift
//  PerferenceKeyExample
//
//  Created by Taewon Yoon on 4/19/24.
//

import SwiftUI

struct GeometryPreferenceKeyView: View {
    @State private var RectangleSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("Hello")
                .frame(width: RectangleSize.width, height: RectangleSize.height)
                .background(.blue)
                
            Spacer()
            
            HStack {
                GeometryReader(content: { geometry in
                    Rectangle()
                        .updateRectangleGeoSize(geometry.size)
                })
                
                Rectangle()

                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometrySizePreferenceKey.self, perform: { value in
            self.RectangleSize = value
        })
    }
}

extension View {
    
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        preference(key: RectangleGeometrySizePreferenceKey.self, value: size)
    }
    
}

struct RectangleGeometrySizePreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


#Preview {
    GeometryPreferenceKeyView()
}

