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
	var iconURL: URL?
	let currentTemperature: String

	init(response: APIResponse) {
		self.city = response.name
		self.description = response.weather.first?.description ?? "No description"
		self.iconURL = nil //başlangıçta nil olarak atanıyor sonra getIconURL fonksiyonu çağrılarak değeri atanacak
		self.currentTemperature = "\(response.main.temp)º"

		// iconURL değeri, getIconURL fonksiyonu çağrılmadan önce atanıyor
		if let iconName = response.weather.first?.iconName {
			self.iconURL = getIconURL(iconCode: iconName)
		}
	}

	private func getIconURL(iconCode: String) -> URL? {
		let iconName: String
		if iconCode.hasSuffix("d") {
			iconName = String(iconCode.dropLast(1))
		} else {
			iconName = String(iconCode.dropLast(1) + "n")
		}
		let urlString = "https://openweathermap.org/img/wn/\(iconName)@2x.png"
		return URL(string: urlString)
	}
}
