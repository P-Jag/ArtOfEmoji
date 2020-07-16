import SwiftUI

struct ArtOfEmojiDocumentView: View {
    @ObservedObject var document: ArtOfEmojiDocument
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(ArtOfEmojiDocument.palette.map { String($0) }, id: \.self ) { emoji in
                        Text(emoji)
                            .font(Font.system(size: self.defaultEmojiSize))
                    }
                }
            }
            .padding(.horizontal)
            Rectangle().foregroundColor(.yellow)
            .edgesIgnoringSafeArea([.horizontal, .bottom])
        }
    }
    private let defaultEmojiSize: CGFloat = 40
}
