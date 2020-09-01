import Combine
import Foundation

protocol WeatherClientProtocol {
    func temperature() -> AnyPublisher<WeatherResponse, Error>
}

struct WeatherClient: WeatherClientProtocol {
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

//struct ColdWeatherClient: WeatherClientProtocol {
//    func temperature() -> AnyPublisher<WeatherResponse, Error> {
//        return Just(
//            WeatherResponse(
//                consolidatedWeather: [.init(applicableDate: .init(), id: 0, maxTemp: 30, minTemp: -10, theTemp: -5)]
//            )
//        )
//        .setFailureType(to: Error.self)
//        .eraseToAnyPublisher()
//    }
//}
//
//struct VeryHotWeatherClient: WeatherClientProtocol {
//
//    func temperature() -> AnyPublisher<WeatherResponse, Error> {
//        return Just(
//            WeatherResponse(
//                consolidatedWeather: [.init(applicableDate: .init(), id: 0, maxTemp: 30000, minTemp: 10, theTemp: 2500)]
//            )
//        )
//        .setFailureType(to: Error.self)
//        .eraseToAnyPublisher()
//    }
//}

struct MockWeatherClient: WeatherClientProtocol {

    var _temperature: Double

    func temperature() -> AnyPublisher<WeatherResponse, Error> {
        return Just(
            WeatherResponse(
                consolidatedWeather: [.init(applicableDate: .init(), id: 0, maxTemp: .greatestFiniteMagnitude, minTemp: .leastNormalMagnitude, theTemp: _temperature)]
            )
        )
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}

