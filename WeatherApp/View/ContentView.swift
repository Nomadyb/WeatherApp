//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 4.05.2024.
//
import SwiftUI
import MapKit

struct ContentView: View {
	@ObservedObject var weatherViewModel: WeatherViewModel
	@StateObject var favoriteLocationViewModel = FavoriteLocationViewModel()
	@State private var showMap = false

	
	init(weatherViewModel: WeatherViewModel) {
		self.weatherViewModel = weatherViewModel
		self.weatherViewModel.loadWeatherData()
	}
	
	var body: some View {
		NavigationView {
			ZStack {
				LinearGradient(gradient: Gradient(colors: [
					Color(red: 0.33, green: 0.29, blue: 0.36), // eggplant
					Color(red: 0.99, green: 0.75, blue: 0.71), // melon
					Color(red: 0.42, green: 0.57, blue: 0.61), // air force blue
					Color(red: 0.93, green: 0.58, blue: 0.57), // light coral
					Color(red: 0.88, green: 0.52, blue: 0.51), // light coral 2
					Color(red: 0.74, green: 0.51, blue: 0.52), // old rose
					Color(red: 0.37, green: 0.53, blue: 0.57)  // air force blue 2
				]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
					
					Button(action: {
						showMap = true
						// Harita entegrasyonu açılacak
						//burası update edilerek her bir favori lokasyon pinlenmelidir.Ayrıca silinen favorilerin pini kalıdırılmalıdır.
					}) {
						Text("Haritada Göster")
							.foregroundColor(.white)
							.font(.system(size: 20))
							.padding()
					}
					.sheet(isPresented: $showMap) {
						MapKitView(viewModel: favoriteLocationViewModel)
					}
				}
				.navigationBarItems(trailing:
										
										NavigationLink(destination: FavoriteLocationView(viewModel: favoriteLocationViewModel)) {
					
					Image(systemName: "plus")
						.foregroundColor(.white)
						.font(.system(size: 24))
						.padding()
				}
				)
			}
		}
	}
}
