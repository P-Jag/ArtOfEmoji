//
//  ArtOfEmoji.swift
//  ArtOfEmoji
//
//  Created by Paweł Jagła on 16/07/2020.
//  Copyright © 2020 Paweł Jagła. All rights reserved.
//

import Foundation

class ArtOfEmoji {
    var backgroundURL: URL?
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable {
        let text: String
        let id: Int
        // 0,0 is a middle of screen
        var x: Int
        var y: Int
        var size: Int
        
        fileprivate init(text: String, id: Int, x: Int, y: Int, size: Int) {
            self.text = text
            self.id = id
            self.x = x
            self.y = y
            self.size = size
        }
    }
    
    private var uniqueEmojiId = 0
    
    func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(text: text, id: uniqueEmojiId, x: x, y: y, size: size))
    }
}
