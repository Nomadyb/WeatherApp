//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 4.05.2024.
//

import SwiftUI
import Foundation

class WeatherViewModel: ObservableObject {
	@Published var weatherModel: WeatherModel?
	private let weatherService: WeatherService

	init(weatherService: WeatherService = WeatherService()) {
		self.weatherService = weatherService
	}

	func loadWeatherData() {
		weatherService.loadWeatherData { [weak self] weatherModel, error in
			guard let self = self else { return }
			if let weatherModel = weatherModel {
				DispatchQueue.main.async {
					self.weatherModel = weatherModel
				}
			} else if let error = error {
				print("Error loading weather data: \(error.localizedDescription)")
			}
		}
	}
}
