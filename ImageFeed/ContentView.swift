import Kingfisher
import SwiftUI

struct ListView: View {
    @StateObject var viewModel = PictureViewModel()
    @State private var page = 1
    @Namespace private var animation
    @State private var selectedPicture: Picture?

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            if selectedPicture == nil {
                List(viewModel.pictures) { picture in
                    KFImage(URL(string: picture.src.tiny))
                        .resizable()
                        .placeholder {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(20)
                        .background(Color.white.opacity(0.1))
                        .matchedGeometryEffect(id: picture.id, in: animation)
                        .onTapGesture {
                            withAnimation {
                                selectedPicture = picture
                            }
                        }
                        .onAppear {
                            if self.viewModel.pictures.isLast(picture) {
                                page += 1
                                viewModel.fetchPictures(page: page)
                            }
                        }
                }
                .listStyle(.plain)
                .onAppear {
                    viewModel.fetchPictures(page: page)
                }
            } else {
                DetailView(picture: $selectedPicture, animation: animation)
                    .matchedGeometryEffect(id: selectedPicture?.id, in: animation)
                    .onTapGesture {
                        withAnimation {
                            selectedPicture = nil
                        }
                    }
            }
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
