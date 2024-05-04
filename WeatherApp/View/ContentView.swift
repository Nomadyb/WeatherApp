//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 4.05.2024.
//
import SwiftUI

struct ContentView: View {
	@ObservedObject var weatherViewModel = WeatherViewModel()

	var body: some View {
		ZStack {
			VStack {
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
						} placeholder: {
							ProgressView()
						}
					}
					
					if let currentTemperature = weatherViewModel.weatherModel?.currentTemperature {
						Text(currentTemperature)
							.font(.system(size: 70))
							.foregroundColor(.white)
					}
				}
				.padding(.top, -20)
				
				HStack(spacing: 14) {
					if let maxTemperature = weatherViewModel.weatherModel?.maxTemperature {
						Label(maxTemperature, systemImage: "thermometer.sun.fill")
					}
					
					if let minTemperature = weatherViewModel.weatherModel?.minTemperature {
						Label(minTemperature, systemImage: "thermometer.snowflake")
					}
				}
				.symbolRenderingMode(.multicolor)
				.foregroundColor(.white)
				
				Divider()
					.foregroundColor(.white)
					.padding()
				
				if let humidity = weatherViewModel.weatherModel?.humidity {
					Label(humidity, systemImage: "humidity.fill")
						.symbolRenderingMode(.multicolor)
						.foregroundColor(.white)
				}
				
				Spacer()
			}
			.padding(.top, 32)
		}
		.background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
		.edgesIgnoringSafeArea(.all)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
