//
//  ContentView.swift
//  CustomErrorAlertExample
//
//  Created by Taewon Yoon on 5/10/24.
//

import SwiftUI

protocol AppAlert {
    var title: String { get }
    var subtitle: String { get }
    var buttons: AnyView { get }
}

extension Binding where Value == Bool {
    
    init<T>(value: Binding<T?>) {
        self.init(get: {
            return value.wrappedValue != nil ? true : false
        }, set: { newValue in
            value.wrappedValue = nil
        })
    }
}

extension View {
    
    func showCustomAlert<T: AppAlert>(alert: Binding<T?>) -> some View {
        self
            .alert(alert.wrappedValue?.title ?? "에러", isPresented: Binding(value: alert), actions: {
                alert.wrappedValue?.buttons
            }) {
                if let subtitle = alert.wrappedValue?.subtitle {
                    Text(subtitle)
                    
                }
            }
    }
}

struct ContentView: View {
    
    @State private var alert: MyCustomAlert? = nil
    
    var body: some View {
        Button("클릭") {
            saveData()
        }
        .showCustomAlert(alert: $alert)
    }
    

    
        
//    enum MyCustomError: Error, LocalizedError {
//        case noInternetConnection
//        case dataNotFound
//        case urlError(error: Error)
//        
//        var errorDescription: String? {
//            switch self {
//            case .noInternetConnection:
//                return "Please check your internet connection and try again."
//            case .dataNotFound:
//                return "There was an error loading data. Please try again."
//            case .urlError(error: let error):
//                return "Error: \(error.localizedDescription)"
//            }
//        }
//    }
    
    enum MyCustomAlert: Error, LocalizedError, AppAlert {
        case noInternetConnection(onOkPressed: () -> Void,  onRetryPressed: () -> Void)
        case dataNotFound
        case urlError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return "Please check your internet connection and try again."
            case .dataNotFound:
                return "There was an error loading data. Please try again."
            case .urlError(error: let error):
                return "Error: \(error.localizedDescription)"
            }
        }
        
        var title: String {
            switch self {
            case .noInternetConnection:
                return "No Internet Connection"
            case .dataNotFound:
                return "No Data"
            case .urlError:
                return "Error"
            }
        }
        
        var subtitle: String {
            switch self {
            case .noInternetConnection:
                return "Please check your internet connection and try again."
            case .dataNotFound:
                return "Data Not Found check again"
            case .urlError(error: let error):
                return "Error: \(error.localizedDescription)"
            }
        }
        
        var buttons: AnyView {
            AnyView(getButtonAlert)
        }
        
        @ViewBuilder var getButtonAlert: some View {
            switch self {
            case .noInternetConnection(onOkPressed: let onOkPressed, onRetryPressed: let onRetryPressed):
                Button("확인") {
                    onOkPressed()
                }
                Button("재시도") {
                    onRetryPressed()
                }
            case .dataNotFound:
                Button("재시도") {
                    
                }
            default:
                Button("삭제") {
                    
                }
            }
        }
    }
    
    private func saveData() {
        let isSuccessful: Bool = false
        
        if isSuccessful {
            
        } else {
            alert = .noInternetConnection(onOkPressed: {
                print("확인 버튼 클릭")
            }, onRetryPressed: {
                print("재시도 버튼 클릭")
            })
        }
    }
}

#Preview {
    ContentView()
}
