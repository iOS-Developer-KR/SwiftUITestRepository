//
//  ContentView.swift
//  UIViewRepresentableExample
//
//  Created by Taewon Yoon on 4/24/24.
//

import SwiftUI

// UIKit의 UIView를 SwiftUI로 바꾸기
struct ContentView: View {
    
    @State private var text: String = ""
    var body: some View {
        VStack {
            Text(text)
            
            HStack {
                Text("SwiftUI")
                    .frame(width: 100)
                TextField("입력...", text: $text)
                    .frame(height: 55)
                    .background(Color.gray)
            }
            HStack {
                Text("UIKit")
                    .frame(width: 100)
                UITextFieldViewRepresentable(text: $text)
                    .updatePlaceholder("New placeholder")
                    .frame(height: 55)
                    .background(Color.gray)
            }
        }
    }
}

#Preview {
    ContentView()
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    let placeholderColor: UIColor
    
    init(text: Binding<String>, placeholder: String = "default", placeholderColor: UIColor = .red) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textfield = getTextField()
        textfield.delegate = context.coordinator
        return textfield
    }
    
    // SwiftUI에서 UIKit로
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextField() -> UITextField {
        let textfield = UITextField(frame: .zero)
        
        let placeholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor : placeholderColor
            ])
        textfield.attributedPlaceholder = placeholder
        return textfield
    }
    
    func updatePlaceholder(_ text: String) -> UITextFieldViewRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    
    // UIKit에서 SwiftUI로
    func makeCoordinator() -> TextFieldDelegate {
        return TextFieldDelegate(text: $text)
    }
    
    class TextFieldDelegate: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
