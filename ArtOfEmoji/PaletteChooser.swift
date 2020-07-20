import SwiftUI

struct PaletteChooser: View {
    @ObservedObject var document: ArtOfEmojiDocument
    
    @Binding var chosenPalette: String
    
    var body: some View {
        
        HStack {
            Stepper(onIncrement: {
                self.chosenPalette = self.document.palette(after: self.chosenPalette)
            }, onDecrement: {
                self.chosenPalette = self.document.palette(before: self.chosenPalette)
            }, label: { EmptyView() })
            Text(self.document.paletteNames[self.chosenPalette] ?? "")
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct PaletteChooser_Previews: PreviewProvider {
    static var previews: some View {
        PaletteChooser(document: ArtOfEmojiDocument(), chosenPalette: Binding.constant(""))
    }
}
