import Foundation
import Kingfisher
import SwiftUI

struct DetailView: View {
    @Binding var picture: Picture?

    var body: some View {
        KFImage(URL(string: picture?.src.large ?? ""))
            .resizable()
            .placeholder {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .onTapGesture {
                withAnimation {
                    picture = nil
                }
            }
    }
}
