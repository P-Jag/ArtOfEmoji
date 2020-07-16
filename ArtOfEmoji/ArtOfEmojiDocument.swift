import SwiftUI

class ArtOfEmojiDocument: ObservableObject {
    
    static let palette: String = "🥩🏊🥁🎯🏖🛌🎈"
    
    @Published private var artOfEmoji: ArtOfEmoji = ArtOfEmoji()
    
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
}
