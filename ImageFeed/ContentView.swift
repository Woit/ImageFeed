import Kingfisher
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PictureViewModel()
    @State private var page = 1

    var body: some View {
        List(viewModel.pictures) { picture in
            KFImage(URL(string: picture.src.tiny))
                .resizable()
                .placeholder {
                    ProgressView()
                }
                .onAppear {
                    if self.viewModel.pictures.isLast(picture) {
                        page += 1
                        viewModel.fetchPictures(page: page)
                    }
                }
        }
        .onAppear {
            viewModel.fetchPictures(page: page)
        }
    }
}

extension Array {
    func isLast<T: Identifiable>(_ element: T) -> Bool {
        guard let lastElement = last as? T else {
            return false
        }
        return lastElement.id == element.id
    }
}
