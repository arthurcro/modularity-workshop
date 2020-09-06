//
//  TemperatureFeatureTests.swift
//  TemperatureFeatureTests
//
//  Created by Arthur Crocquevieille on 01/09/2020.
//

import Combine
@testable import TemperatureFeature
@testable import WeatherClient
import XCTest

final class TemperatureFeatureTests: XCTestCase {

    func testBasics() {
        let viewModel = TemperatureViewModel(
            isLoading: false,
            temperature: nil,
            weatherClient: .init(temperature: { .init(.mock(20)) })
        )
        viewModel.weatherTapped()
        let exp = expectation(description: "Test after 0.2 seconds")
        XCTWaiter().wait(for: [exp], timeout: 0.2)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.temperature == "20.0")
    }
}

extension WeatherResponse {

    static func mock(_ temperature: Double) -> WeatherResponse {
        return  Self(
            consolidatedWeather: [
                .init(
                    applicableDate: .init(timeIntervalSince1970: 0),
                    id: 0,
                    maxTemp: .greatestFiniteMagnitude,
                    minTemp: .leastNormalMagnitude,
                    theTemp: temperature
                )
            ]
        )
    }
}

extension AnyPublisher {

    init(_ value: Output) {
        self = Just(value)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }
}
