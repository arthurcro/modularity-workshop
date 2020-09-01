import Combine
import Foundation

public extension WeatherClient {

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
