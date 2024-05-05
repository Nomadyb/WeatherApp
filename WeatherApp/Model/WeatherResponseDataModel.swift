//
//  WeatherResponseDataModel.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 5.05.2024.
//

import Foundation

struct WeatherResponseDataModel: Decodable {
	// Burada API'den gelen verilere uygun şekilde değişkenler tanımlanmalıdır.
	// Örneğin:
	let city: String
	let temperature: Double
	// Diğer veri alanları...
}
