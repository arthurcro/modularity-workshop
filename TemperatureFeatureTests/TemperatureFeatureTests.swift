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
        let queue = DispatchQueue(label: "test_queue")
        let viewModel = TemperatureViewModel(
            isLoading: false,
            queue: queue,
            temperature: nil,
            weatherClient: .init(temperature: {
                return Just(
                    WeatherResponse(
                                consolidatedWeather: [
                                    .init(
                                        applicableDate: .init(timeIntervalSince1970: 0),
                                        id: 0,
                                        maxTemp: 200,
                                        minTemp: 0,
                                        theTemp: 20
                                    )
                                ]
                    )
                )
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            })
        )
        viewModel.weatherTapped()
        XCTAssertTrue(!viewModel.isLoading)
        XCTAssertTrue(viewModel.temperature == "20.0")
    }
}
