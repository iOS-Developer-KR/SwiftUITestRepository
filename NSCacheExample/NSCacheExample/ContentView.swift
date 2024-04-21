//
//  ContentView.swift
//  NSCacheExample
//
//  Created by Taewon Yoon on 4/19/24.
//

import SwiftUI

class CacheManager {
    static let instance = CacheManager() // 싱글톤
    private init() {  }
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>() //커스텀화하기 위해서 변수로 만듬
        cache.countLimit = 100 // cache가 몇개의 데이터를 갖고 있을 수 있는지
        cache.totalCostLimit = 1024 * 1024 * 100  // 캐시가 이터를 얼마나 크게 갖고 있을 수 있는지 (100mb)
        return cache
    }()
    
    func add(image: UIImage, name: String) -> String{
        imageCache.setObject(image, forKey: name as NSString)
        return "캐시에 저장 완료"
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "캐시에서 삭제 완료"
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
    
}

@Observable
class CacheViewModel {
    
    var startingImage: UIImage? = nil
    var cachedImage: UIImage? = nil
    var infoMessage: String = ""
    let imageName: String = "hello"
    let manager = CacheManager.instance
    
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "캐시에서 이미지 수신"
        } else {
            infoMessage = "캐시에 이미지 없음"
            cachedImage = nil
        }
        
    }
}

struct ContentView: View {
    
    @Environment(CacheViewModel.self) var vm
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundStyle(.purple)
                
                HStack {
                    Button(action: {
                        vm.saveToCache()
                    }, label: {
                        Text("캐시에 저장하기")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    Button(action: {
                        vm.removeFromCache()
                    }, label: {
                        Text("캐시에서 삭제하기")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    
                }
                Button(action: {
                    vm.getFromCache()
                }, label: {
                    Text("캐시에서 가져오기")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(CacheViewModel())
}
