//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 4.05.2024.
//

import Foundation

final class WeatherViewModel: ObservableObject {
	@Published var weatherModel: WeatherModel? // Optional olarak tanımlanabilir
	private let weatherService = WeatherService()

	init() {
		weatherService.loadWeatherData { [weak self] weatherModel, error in
			guard let self = self else { return }
			if let weatherModel = weatherModel {
				DispatchQueue.main.async {
					self.weatherModel = weatherModel
				}
			} else if let error = error {
				print("Location authorization error:", error.localizedDescription)
			}
		}
	}
}
