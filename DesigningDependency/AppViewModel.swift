import Combine
import Foundation

class AppViewModel: ObservableObject {

    @Published var temperature: String?
    @Published var isLoading: Bool

    private let weatherClient: WeatherClient
    private var cancellable: AnyCancellable?

    init(
        isLoading: Bool = false,
        temperature: String? = nil,
        weatherClient: WeatherClient
    ) {
        self.isLoading = isLoading
        self.temperature = temperature
        self.weatherClient = weatherClient
    }

    func computeTapped() {
        cancellable?.cancel()
        temperature = nil
        isLoading = true

        cancellable = weatherClient
            .temperature()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] error in self?.isLoading = false },
                receiveValue: { [weak self] response in
                    self?.isLoading = false
                    self?.temperature = "\(response.consolidatedWeather.first!.theTemp)"
                }
            )
    }
}

extension JSONDecoder {

    static var weatherJsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(formatter)
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
}
