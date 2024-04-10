import SwiftUI
import BackgroundTasks

@main
struct BackgroundTaskExampleApp: App {
    @StateObject var imageStore = ImageStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView(imageStore: imageStore)
        }
        .backgroundTask(.appRefresh("randomImage")) { // Mark 1 This is where you respond the scheduled background task
            // you can also reschedule the background task HERE if you want to keep calling from time to time, just send BGTaskScheduler.shared.submit(request) here again and again.
            await refreshAppData() // use an async function here
        }
    }
    
    func refreshAppData() async { // this is the functio that will respond your scheduled background task
        let content = UNMutableNotificationContent()
        content.title = "A Random Photo is awaiting for you!"
        content.subtitle = "Check it now!"
        
        if await fetchRandomImage() {
            try? await UNUserNotificationCenter.current().add(UNNotificationRequest(identifier: "test", content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)))
        }
    }
    
    func fetchRandomImage() async -> Bool { // async random fetch image
        do {
            guard let url = URL(string: "https://picsum.photos/200/300"),
                  do {
                      let (data, response) = try? await URLSession.shared.data(from: url)
                  } catch {
                      print(error)
                  },
                  let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return false
            }
            
            imageStore.randomImage = UIImage(data: data)
        } catch {
            print(error)
        }
        
        return true
    }
}
