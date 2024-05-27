import Foundation
import Kingfisher
import SwiftUI

struct DetailView: View {
    @Binding var picture: Picture?

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            KFImage(URL(string: picture?.src.large ?? ""))
                .resizable()
                .placeholder {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .onTapGesture {
                    withAnimation {
                        picture = nil
                    }
                }
        }
    }
}
