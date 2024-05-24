import Combine
import Foundation
import SwiftUI

class PictureViewModel: ObservableObject {
    @Published var pictures: [Picture] = []
    var cancellables = Set<AnyCancellable>()

    func fetchPictures(page: Int) {
        guard let url = URL(string: "https://api.pexels.com/v1/curated/?page=\(page)&per_page=\(Config.picturesPerPage)") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue(Config.apiKey, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: PicturesList.self, decoder: JSONDecoder())
            .map { $0.photos }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error: \(error)")

                    default:
                        break
                    }
                },
                receiveValue: { [weak self] pictures in
                    self?.pictures += pictures
                }
            )
            .store(in: &cancellables)
    }
}
