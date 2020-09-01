import Combine
import Foundation

struct WeatherClient {
    func temperature() -> AnyPublisher<WeatherResponse, Error> {
        return URLSession
            .shared
            .dataTaskPublisher(for: URL(string: "https://www.metaweather.com/api/location/2459115")!)
            .map { data, _ in data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder.weatherJsonDecoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
