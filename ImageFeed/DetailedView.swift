import Foundation
import Kingfisher
import SwiftUI

struct DetailView: View {
    @Binding var picture: Picture?
    let animation: Namespace.ID

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                KFImage(URL(string: picture?.src.large ?? ""))
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: picture?.id, in: animation)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .onTapGesture {
            picture = nil
        }
    }
}
