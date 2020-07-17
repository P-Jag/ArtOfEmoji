import SwiftUI

class ArtOfEmojiDocument: ObservableObject {
    
    static let palette: String = "🥩🏊🥁🎯🏖🛌🎈"
    
//    @Published
    private var artOfEmoji: ArtOfEmoji {
        willSet {
            objectWillChange.send()
        }
        
        didSet {
            UserDefaults.standard.set(artOfEmoji.json, forKey: ArtOfEmojiDocument.untitled)
        }
    }
    
    private static var untitled = "ArtOfEmoji.Untitled"
    
    init() {
        artOfEmoji = ArtOfEmoji(json: UserDefaults.standard.data(forKey: ArtOfEmojiDocument.untitled)) ?? ArtOfEmoji()
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
    
    func setBackgroundUrl(_ url: URL?){
        artOfEmoji.backgroundURL = url?.imageURL
        fetchBackgroundImageData()
    }
    
    private func fetchBackgroundImageData(){
        backgroundImage = nil
        if let url = artOfEmoji.backgroundURL {
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        if url == self.artOfEmoji.backgroundURL {
                            self.backgroundImage = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
}

extension ArtOfEmoji.Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}
