import Kingfisher
import SwiftUI

struct ListView: View {
    @StateObject var viewModel = PictureViewModel()
    @State private var page = 1
    @State private var selectedPicture: Picture?

    var body: some View {
        List(viewModel.pictures) { picture in
            ZStack {
                KFImage(URL(string: picture.src.tiny))
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(20)
                    .padding(.horizontal, 10)
                    .shadow(radius: 10)
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
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(picture.photographer)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .padding(4)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(10)
                            .padding(.top)
                            .padding(.leading)
                    }
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.fetchPictures(page: page)
        }
        .overlay(
            Group {
                if selectedPicture != nil {
                    DetailView(picture: $selectedPicture)
                        .onTapGesture {
                            selectedPicture = nil
                        }
                }
            }
        )
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
