import Combine
import Foundation

public struct WeatherClient {
    
    public var temperature: () -> AnyPublisher<WeatherResponse, Error>

    public init(
        temperature: @escaping () -> AnyPublisher<WeatherResponse, Error>
    ) {
        self.temperature = temperature
    }
}
