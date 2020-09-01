//
//  WeatherResponse.swift
//  DesigningDependency
//
//  Created by Arthur Crocquevieille on 01/09/2020.
//

import Foundation

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

extension WeatherResponse {

    static func mock(temperature: Double) -> WeatherResponse {
        WeatherResponse(
            consolidatedWeather: [.init(applicableDate: .init(), id: 0, maxTemp: .greatestFiniteMagnitude, minTemp: .leastNormalMagnitude, theTemp: temperature)]
        )
    }
}
