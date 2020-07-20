import SwiftUI
import Combine

class ArtOfEmojiDocument: ObservableObject {
    
    static let palette: String = "🥩🏊🥁🎯🏖🛌🎈"
    
    @Published private var artOfEmoji: ArtOfEmoji
    
    private static var untitled = "ArtOfEmoji.Untitled"
    
    private var autosaveCancellable: AnyCancellable?
    init() {
        artOfEmoji = ArtOfEmoji(json: UserDefaults.standard.data(forKey: ArtOfEmojiDocument.untitled)) ?? ArtOfEmoji()
        autosaveCancellable = $artOfEmoji.sink { artOfEmoji in
            UserDefaults.standard.set(artOfEmoji.json, forKey: ArtOfEmojiDocument.untitled )
        }
        fetchBackgroundImageData()
    }
    
    @Published private(set) var backgroundImage: UIImage?
    
    var emojis: [ArtOfEmoji.Emoji] { artOfEmoji.emojis }
    
    //MARK: - Intent(s)
    
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat){
        artOfEmoji.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji: ArtOfEmoji.Emoji, by offset: CGSize){
        if let index = artOfEmoji.emojis.firstIndex(matching: emoji) {
            artOfEmoji.emojis[index].x += Int(offset.width)
            artOfEmoji.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: ArtOfEmoji.Emoji, by scale: CGFloat){
        if let index = artOfEmoji.emojis.firstIndex(matching: emoji) {
            artOfEmoji.emojis[index].size = Int((CGFloat(artOfEmoji.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }
    
    var backgroundURL: URL? {
        get {
            artOfEmoji.backgroundURL
        }
        set {
            artOfEmoji.backgroundURL = newValue?.imageURL
            fetchBackgroundImageData()
        }
    }
    
    private var fetchImageCancellable: AnyCancellable?
    
    private func fetchBackgroundImageData(){
        backgroundImage = nil
        if let url = artOfEmoji.backgroundURL {
            fetchImageCancellable?.cancel()
            let session = URLSession.shared
            let publisher = session.dataTaskPublisher(for: url)
                .map { data, URLResponse in UIImage(data: data) }
                .receive(on: DispatchQueue.main)
                .replaceError(with: nil)
           fetchImageCancellable = publisher.assign(to: \ArtOfEmojiDocument.backgroundImage, on: self)
        }
    }
}

extension ArtOfEmoji.Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}
