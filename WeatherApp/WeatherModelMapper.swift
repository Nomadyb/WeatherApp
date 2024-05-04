//
//  WeatherModelMapper.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 4.05.2024.
//
import Foundation

struct WeatherModelMapper {
	func mapDataModelToModel(dataModel: APIResponse?) -> WeatherModel {
		guard let response = dataModel,
			  let weather = response.weather.first else {
			return WeatherModel(city: "", description: "", iconURL: nil, currentTemperature: "", minTemperature: "", maxTemperature: "", humidity: "")
		}
		
		return WeatherModel(city: response.name,
							description: "(\(weather.description))",
							iconURL: URL(string: "http://openweathermap.org/img/wn/\(weather.iconName)@2x.png"),
							currentTemperature: "\(response.main.temp)º",
							minTemperature: "\(response.main.tempMin)º Min.",
							maxTemperature: "\(response.main.tempMax)º Max.",
							humidity: "\(response.main.humidity)%")
	}
}
