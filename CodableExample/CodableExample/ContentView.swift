//
//  ContentView.swift
//  CodableExample
//
//  Created by Taewon Yoon on 4/8/24.
//

import SwiftUI

struct CustomerModel: Identifiable, Codable {//Decodable, Encodable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    init(id: String, name: String, points: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case points
//        case isPremium
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//    
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(points, forKey: .points)
//        try container.encode(isPremium, forKey: .isPremium)
//    }
}

@Observable class CodableViewModel {
    var customer: CustomerModel? = nil // = CustomerModel(id: "1", name: "Yoon", points: 5, isPremium: true)
    
    init() {
        getData()
    }
    
    func getData() {
        
        guard let data = getJSONData() else { return }
        
        do {
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        } catch {
            print("decoding error: \(error)")
        }
    }
    
    func getJSONData() -> Data? {
        
        let customer = CustomerModel(id: "1", name: "KIM", points: 87, isPremium: false)
        let jsonData = try? JSONEncoder().encode(customer)
//        let dictionary: [String:Any] = [
//            "id" : "12345",
//            "name": "Yoon",
//            "points" : 5,
//            "isPremium" : true
//        ]
        
////         변환하고 싶은 데이터를 JSON으로 만들기, try? 로 선언하면 실패해도 된다는 의미
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary)
        return jsonData
    }
}

struct ContentView: View {
    
    @Environment(CodableViewModel.self) var vm
    
    var body: some View {
        VStack {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(CodableViewModel())
}
