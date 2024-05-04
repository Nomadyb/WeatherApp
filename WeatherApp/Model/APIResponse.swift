//
//  APIResponse.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 5.05.2024.
//

import Foundation

public struct APIResponse: Decodable {
	let name: String
	let main: APIMain
	let weather: [APIWeather]
}

public struct APIMain: Decodable {
	let temp: Double
	let tempMin: Double
	let tempMax: Double
	let humidity: Int

	enum CodingKeys: String, CodingKey {
		case temp
		case tempMin = "temp_min"
		case tempMax = "temp_max"
		case humidity
	}
}

public struct APIWeather: Decodable {
	let description: String
	let iconName: String

	enum CodingKeys: String, CodingKey {
		case description
		case iconName = "main"
	}
}
