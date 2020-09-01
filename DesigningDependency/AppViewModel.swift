import Combine
import Foundation

class AppViewModel: ObservableObject {

    @Published var temperature: String?
    @Published var isLoading: Bool

    private var cancellable: AnyCancellable?

    init(
        isLoading: Bool = false,
        temperature: String? = nil
    ) {
        self.isLoading = isLoading
        self.temperature = temperature
    }

    func computeTapped() {
        cancellable?.cancel()
        temperature = nil
        isLoading = true

        cancellable = URLSession
            .shared
            .dataTaskPublisher(for: URL(string: "https://www.metaweather.com/api/location/2459115")!)
            .map { data, _ in data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder.weatherJsonDecoder)
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

struct WeatherResponse: Decodable, Equatable {
    var consolidatedWeather: [ConsolidatedWeather]

    struct ConsolidatedWeather: Decodable, Equatable {
        var applicableDate: Date
        var id: Int
        var maxTemp: Double
        var minTemp: Double
        var theTemp: Double
    }
}
