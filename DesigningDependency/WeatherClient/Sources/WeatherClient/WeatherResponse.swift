//
//  WeatherResponse.swift
//  DesigningDependency
//
//  Created by Arthur Crocquevieille on 01/09/2020.
//

import Foundation

public struct WeatherResponse: Decodable, Equatable {

    public var consolidatedWeather: [ConsolidatedWeather]

    public struct ConsolidatedWeather: Decodable, Equatable {
        public var applicableDate: Date
        public var id: Int
        public var maxTemp: Double
        public var minTemp: Double
        public var theTemp: Double
    }
}

public extension WeatherResponse {

    static func mock(temperature: Double) -> WeatherResponse {
        WeatherResponse(
            consolidatedWeather: [.init(applicableDate: .init(), id: 0, maxTemp: .greatestFiniteMagnitude, minTemp: .leastNormalMagnitude, theTemp: temperature)]
        )
    }
}
