import Combine
import Foundation
import WeatherClient

public class TemperatureViewModel: ObservableObject {

    @Published var isLoading: Bool
    @Published var temperature: String?

    private var cancellable: AnyCancellable?
    private let queue: DispatchQueue
    private let weatherClient: WeatherClient


    public init(
        isLoading: Bool = false,
        queue: DispatchQueue = .main,
        temperature: String? = nil,
        weatherClient: WeatherClient
    ) {
        self.isLoading = isLoading
        self.queue = queue
        self.temperature = temperature
        self.weatherClient = weatherClient
    }

    func weatherTapped() {
        cancellable?.cancel()
        temperature = nil
        isLoading = true

        cancellable = weatherClient
            .temperature()
            .receive(on: queue)
            .sink(
                receiveCompletion: { [weak self] error in self?.isLoading = false },
                receiveValue: { [weak self] response in
                    self?.isLoading = false
                    self?.temperature = "\(response.consolidatedWeather.first!.theTemp)"
                }
            )
    }
}
