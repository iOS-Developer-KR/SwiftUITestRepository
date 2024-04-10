import SwiftUI
import BackgroundTasks

class ImageStore: ObservableObject {
    @Published var randomImage: UIImage?
}

struct ContentView: View {
    
    @ObservedObject var imageStore: ImageStore
    
    var body: some View {
        VStack {
            
            Button("Local Message Autorization") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                        
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }.buttonStyle(.borderedProminent)
                .padding()
            
            Button("Schedule Background Task") {
                let request = BGAppRefreshTaskRequest(identifier: "randomImage") // Mark 1
                request.earliestBeginDate = Calendar.current.date(byAdding: .second, value: 30, to: Date()) // Mark 2
                do {
                    try BGTaskScheduler.shared.submit(request) // Mark 3
                    print("Background Task Scheduled!")
                } catch(let error) {
                    print("Scheduling Error \(error.localizedDescription)")
                }
                
            }.buttonStyle(.bordered)
                .tint(.red)
                .padding()
            
        }
    }
}
