//
//   LocationServiceModel.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 5.05.2024.
//

import Foundation
import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {
	private let locationManager = CLLocationManager()
	private let API_KEY = "a0f209e39225cace39d2b90ddfc6a658"
	private var completionHandler: ((Location?, Error?) -> Void)?
	private var dataTask: URLSessionDataTask?

	override init() {
		super.init()
		locationManager.delegate = self
	}

	func searchCity(withName name: String, completion: @escaping (Location?, Error?) -> Void) {
		guard let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=\(API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
			completion(nil, LocationServiceError.invalidCityName)
			return
		}
		guard let url = URL(string: urlString) else {
			completion(nil, LocationServiceError.invalidURL)
			return
		}

		dataTask?.cancel()

		dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
			guard error == nil, let data = data else {
				completion(nil, error)
				return
			}

			if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
				let location = Location(name: response.name, temperature: "\(response.main.temp)°C", weatherCondition: response.weather[0].description)
				completion(location, nil)
			} else {
				completion(nil, LocationServiceError.invalidData)
			}
		}
		dataTask?.resume()
	}
	// Diğer fonksiyonlar ve delegate metodları buraya eklenebilir...
}

// LocationService hataları
enum LocationServiceError: Error {
	case invalidCityName
	case invalidURL
	case invalidData
}
