//
//  OptionalImage.swift
//  ArtOfEmoji
//
//  Created by Paweł Jagła on 17/07/2020.
//  Copyright © 2020 Paweł Jagła. All rights reserved.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if uiImage != nil {
            Image(uiImage: uiImage!)
            }
        }
    }
}
