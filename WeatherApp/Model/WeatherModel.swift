//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 4.05.2024.
//

import Foundation

struct WeatherModel {
	let city: String
	let description: String
	let iconURL: URL? // Yeni eklenen özellik
	let currentTemperature: String
	let minTemperature: String
	let maxTemperature: String
	let humidity: String

	init(response: APIResponse) {
		self.city = response.name
		self.description = response.weather.first?.description ?? "No description"
		self.iconURL = URL(string: "http://openweathermap.org/img/wn/\(response.weather.first?.iconName ?? "")@2x.png") // iconURL oluşturuldu
		self.currentTemperature = "\(response.main.temp)º"
		self.minTemperature = "\(response.main.tempMin)º Min."
		self.maxTemperature = "\(response.main.tempMax)º Max."
		self.humidity = "\(response.main.humidity)%"
	}
}
