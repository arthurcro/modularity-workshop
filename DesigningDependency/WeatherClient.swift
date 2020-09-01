import Combine
import Foundation

struct WeatherClient {
    var temperature: () -> AnyPublisher<WeatherResponse, Error>
}

extension WeatherClient {

    static let live = Self {
        return URLSession
            .shared
            .dataTaskPublisher(for: URL(string: "https://www.metaweather.com/api/location/2459115")!)
            .map { data, _ in data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder.weatherJsonDecoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    static let hot = Self {
        return Just(WeatherResponse.mock(temperature: 500))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    static let cold = Self {
        return Just(WeatherResponse.mock(temperature: -500))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
