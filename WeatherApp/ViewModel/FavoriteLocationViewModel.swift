//
//  FavoriteLocationViewModel.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 5.05.2024.
//

// FavoriteLocationViewModel.swift
import Foundation

class FavoriteLocationViewModel: ObservableObject {
	@Published var searchResults: [Location] = []
	@Published var favorites: [Location] = []

	func searchLocation(cityName: String) {
		let locationService = LocationService()
		locationService.searchCity(withName: cityName) { weatherModel, error in
			if let error = error {
				print("Error searching city: \(error.localizedDescription)")
				// Hata durumunu ele alabilirsiniz
				return
			}

			if let weatherModel = weatherModel {
				let location = Location(name: weatherModel.name, temperature: "\(weatherModel.temperature)", humidity: nil, weatherCondition: weatherModel.weatherCondition)
				DispatchQueue.main.async {
					self.searchResults.removeAll()
					self.searchResults.append(location)
				}
			} else {
				print("No weather data found for the city")
				// Şehre ait hava durumu verisi bulunamadı
			}
		}
	}

	func addFavorite(_ location: Location) {
		if !favorites.contains(where: { $0.name == location.name }) {
			favorites.append(location)
		}
	}

	func removeFavorite(_ location: Location) {
		if let index = favorites.firstIndex(where: { $0.name == location.name }) {
			favorites.remove(at: index)
		}
	}
}
