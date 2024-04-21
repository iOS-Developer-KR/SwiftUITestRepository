//
//  ContentView.swift
//  DownLoadWithCombineExample
//
//  Created by Taewon Yoon on 4/21/24.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

@Observable
class DownloadWithCombineViewModel {
    var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var cancellables = Set<AnyCancellable>()
        
        
        /*
         // 1. 매달 우유 배달을 구독하여 신문 배달이 온다
         // 2. 회사는 구독한 사람들을 위해서 사람들이 못보는 곳에서 우유를 만든다
         // 3. 만든 우유을 회사에서 구독자들에게 배달을 한다
         // 4. 배달받은 우유병이 손상되지 않았는지 확인한다
         // 5. 우유병을 열어서 제대로된 우유인지를 확인한다
         // 6. 제대로된 우유라면 마신다.
         // 7. 구독을 언제든지 취소할 수 있다.
         
         // 1. publisher 만들기 // 시간이 지남에 따라 값을 publish합니다.
         // 2. 백그라운드 스레드에서 publisher 구독하기 // 데이터를 효율적으로 가져오기 위해서
         // 3. 메인스레드에서 수신받기 // UI는 메인 스레드에서 업데이트되기 때문에
         // 4. tryMap (데이터가 괜찮은지 확인하기)
         // 5. 데이터 디코딩하기
         // 6. sink (데이터를 앱에 넣기)
         // 7. store (취소 가능하도록 만들기)
         */
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("Error Occurred: \(error)")
                }
                print("COMPLETION: \(completion)")
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

struct ContentView: View {
    
    @Environment(DownloadWithCombineViewModel.self) var vm
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(DownloadWithCombineViewModel())
}
