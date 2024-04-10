//
//  ContentView.swift
//  Testing_Notification
//
//  Created by Taewon Yoon on 1/15/24.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    let store = HKHealthStore()
    @State var data: [HKQuantitySample]?
    
    func requestAuthorization() {

        // The quantity types to read from the health store.
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
        ]

        // Request authorization for those quantity types.
        store.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            // Handle error.
        }
    }
    
    func sampleQuery() async {
        if HKHealthStore.isHealthDataAvailable() {
            // Add code to use HealthKit here.
            
            // Define the type.
            let stepType = HKQuantityType(.stepCount)
            
            
            // Create the descriptor.
            let descriptor = HKSampleQueryDescriptor(
                predicates:[.quantitySample(type: stepType)],
                sortDescriptors: [SortDescriptor(\.endDate, order: .reverse)],
                limit: 10)
            
            
            // Launch the query and wait for the results.
            // The system automatically sets results to [HKQuantitySample].
            
            do {
                let results = try await descriptor.result(for: store)
                data = results
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    var body: some View {
        List {
            if let data = data {
                ForEach(data, id: \.self) { sample in
                    Text("\(sample.startDate) -> \(sample.endDate)")
                }
            }
        }
        .onAppear {
            requestAuthorization()
            Task {
                await sampleQuery()
            }
        }
    }
}
#Preview {
   ContentView()
}

