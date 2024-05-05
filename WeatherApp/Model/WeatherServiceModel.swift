//
//  WeatherServiceModel.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 4.05.2024.
//


import CoreLocation
import Foundation

final class WeatherService: NSObject, CLLocationManagerDelegate {
	private let locationManager = CLLocationManager()
	private let API_KEY = "a0f209e39225cace39d2b90ddfc6a658" // Replace with your own API key
	private var completionHandler: ((WeatherModel?, Error?) -> Void)?
	private var dataTask: URLSessionDataTask?

	override init() {
		super.init()
		locationManager.delegate = self
	}

	internal func loadWeatherData(
		_ completionHandler: @escaping ((WeatherModel?, Error?) -> Void)
	) {
		self.completionHandler = completionHandler
		loadDataOrRequestLocationAuth()
	}

	private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
		guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
		guard let url = URL(string: urlString) else { return }

		// Cancel previous task
		dataTask?.cancel()

		dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
			guard error == nil, let data = data else {
				self.completionHandler?(nil, error)
				return
			}

			if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
				let weatherModel = WeatherModel(response: response)
				self.completionHandler?(weatherModel, nil)
			}
		}
		dataTask?.resume()
	}

	private func loadDataOrRequestLocationAuth() {
		switch locationManager.authorizationStatus {
		case .authorizedAlways, .authorizedWhenInUse:
			locationManager.startUpdatingLocation()
		case .denied, .restricted:
			completionHandler?(nil, LocationAuthError())
		default:
			locationManager.requestWhenInUseAuthorization()
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else { return }
		makeDataRequest(forCoordinates: location.coordinate)
	}

	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		loadDataOrRequestLocationAuth()
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Something went wrong: \(error.localizedDescription)")
	}
}

struct LocationAuthError: Error {}

struct APIResponse: Decodable {
	let name: String
	let main: APIMain
	let weather: [APIWeather]
}

struct APIMain: Decodable {
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

struct APIWeather: Decodable {
	let description: String
	let iconName: String

	enum CodingKeys: String, CodingKey {
		case description
		case iconName = "main"
	}
}
