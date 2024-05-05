//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 4.05.2024.
//
import SwiftUI

struct ContentView: View {
	@ObservedObject var weatherViewModel: WeatherViewModel

	init(weatherViewModel: WeatherViewModel) {
		self.weatherViewModel = weatherViewModel
		self.weatherViewModel.loadWeatherData() // WeatherViewModel başlatılırken loadWeatherData çağrılıyor
	}

	var body: some View {
		ZStack {
			LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
				.edgesIgnoringSafeArea(.all)

			VStack {
				Spacer()

				if let city = weatherViewModel.weatherModel?.city {
					Text(city)
						.foregroundColor(.white)
						.font(.system(size: 70))
				}

				if let description = weatherViewModel.weatherModel?.description {
					Text(description)
						.font(.headline)
						.foregroundColor(.white)
						.padding(.bottom, 8)
				}

				HStack {
					if let url = weatherViewModel.weatherModel?.iconURL {
						AsyncImage(url: url) { image in
							image
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 50, height: 50)
						} placeholder: {
							Image(systemName: "cloud.sun.fill")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 50, height: 50)
								.foregroundColor(.white)
						}
					}

					if let currentTemperature = weatherViewModel.weatherModel?.currentTemperature {
						Text(currentTemperature)
							.font(.system(size: 70))
							.foregroundColor(.white)
					}
				}
				.padding(.top, 20)

				Spacer()
			}
		}
	}
}
