import SwiftUI
import Lottie

// .json <- OLD
// .dotLottie <- NEW

struct ContentView: View {
    
    var fileName: String = "Animation.json"
    var contentMode: UIView.ContentMode = .scaleAspectFill
    var playLoopMode: LottieLoopMode = .playOnce
    var onAnimationDidFinish: (() -> Void)? = nil
    
    var body: some View {
        LottieView(animation: .named("Animation.json"))
            .configure({ lottieAnimationView in
                lottieAnimationView.contentMode = contentMode
            })
            .playbackMode(.playing(.toProgress(1, loopMode: playLoopMode)))
            .animationDidFinish { completed in
                onAnimationDidFinish?()
            }
            
    }
}

#Preview {
    ContentView()
}
