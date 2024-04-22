//
//  CustomNavBarView.swift
//  CustomNavigationBarExample
//
//  Created by Taewon Yoon on 4/23/24.
//

import Foundation
import SwiftUI

struct CustomNavBarView: View {
    var body: some View {
        HStack {
            Button(action: {}, label: {
                Image(systemName: "chevron.left")
            })
            
            Spacer()
            
            VStack(spacing: 4, content: {
                Text("Placeholder")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Subtitle goes here")
            })
            
            Spacer()
            
            Button(action: {}, label: {
                Image(systemName: "chevron.left")
            })
            .opacity(0)
        }
        .tint(.white)
        .font(.headline)
        .background(.blue)
        

    }
}


#Preview {
    VStack {
        CustomNavBarView()
        Spacer()
    }
}
