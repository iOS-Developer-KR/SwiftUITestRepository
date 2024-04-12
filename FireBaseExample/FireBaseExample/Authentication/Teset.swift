//
//  Teset.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/12/24.
//

import SwiftUI


class testDiscardableResult {
    
    @discardableResult
    func getData() -> String {
        return "iOS-Developer"
    }
}



struct Test: View {
    var body: some View {
        Button(action: {
            testDiscardableResult().getData()
        }, label: {
            Text("버튼")
        })
    }
}

#Preview {
    Test()
}
