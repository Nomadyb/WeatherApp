//
//  FavoriteLocationView.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 5.05.2024.
//

// FavoriteLocationView.swift
import SwiftUI



struct FavoriteLocationView: View {
	@ObservedObject var viewModel: FavoriteLocationViewModel
	@State private var searchText = ""
	
	var body: some View {
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
				Text("Hava Durumu")
					.font(.title)
					.padding(.top, 50) // Başlık yüksekliği
				
				SearchBar(viewModel: viewModel, searchText: $searchText)
				
				Spacer() // Favori şehirlerin üstündeki boşluğu ayarlamayı unutma
				
				Divider()
					.padding(.bottom)
				
				if viewModel.favorites.isEmpty {
					Text("Henüz favori şehir eklenmemiş")
						.foregroundColor(.secondary)
						.padding()
				} else {
					ScrollView {
						LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 16) {
							ForEach(viewModel.favorites, id: \.name) { location in
								FavoriteItemView(location: location, action: {
									viewModel.removeFavorite(location)
								})
							}
						}
						.padding()
					}
				}
			}
		}
		.ignoresSafeArea(.all, edges: .top)
	}
}



struct SearchBar: View {
	@ObservedObject var viewModel: FavoriteLocationViewModel
	@Binding var searchText: String
	@State private var showSearchResults = false // Arama sonuçlarını göstermek için durumu tutar
	@State private var offset: CGFloat = 10.0
	var body: some View {
		VStack {
			HStack {
				TextField("Arama yapın", text: $searchText)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.padding(.horizontal)
				
				Button(action: {
					viewModel.searchLocation(cityName: searchText)
					showSearchResults = true
				}) {
					Image(systemName: "magnifyingglass")
						.foregroundColor(.gray)
						.padding()
				}
			}

			// Arama sonuçlarını göster
			if showSearchResults {
				ZStack(alignment: .topLeading) {
					RoundedRectangle(cornerRadius: 10)
						.fill(Color.white)
						.shadow(radius: 5)
					
					VStack(alignment: .leading) {
						ForEach(viewModel.searchResults, id: \.name) { location in
							Button(action: {
								viewModel.addFavorite(location)
								showSearchResults = false // Sonuçları gizle
							}) {
								Text(location.name)
									.font(.subheadline)
									.foregroundColor(.primary)
									.padding(.vertical, 8)
									.padding(.horizontal, 16)
									.background(Color.white)
									.cornerRadius(10)
									.shadow(radius: 2)
									.padding(.bottom, 4)
							}
						}
					}
					.padding()
				}
				.frame(height: 15)
				.transition(.opacity)
				.animation(Animation.easeInOut(duration: 1.0), value: offset)//animasyon güncellemeyi unutma
				.padding(.horizontal)
				.padding(.top, 4)
			}
		}
		.padding(.horizontal)
	}
}




struct FavoriteItemView: View {
	var location: Location
	var action: () -> Void

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(location.name)
				.font(.title3)
				.foregroundColor(.primary)
				.lineLimit(1) // Sadece bir satırda görüntüle
			
			Text(location.temperature)
				.foregroundColor(.secondary)
				.font(.subheadline)
			
			Text(location.weatherCondition) // Hava durumu bilgisi
				.foregroundColor(.secondary)
				.font(.subheadline)
			
			Text(location.humidity ?? "") // Nem oranı bilgisi
				.foregroundColor(.secondary)
				.font(.subheadline)

			Spacer()

			Button(action: action) {
				Image(systemName: "xmark.circle.fill")
					.foregroundColor(.red)
					.padding(20)
					.background(Color.clear)
			}
			.contentShape(Rectangle())
		}
		.padding(15)
		.frame(width: 180, height: 180)
		.background(
			RoundedRectangle(cornerRadius: 10)
				.fill(Color.white)
				.shadow(radius: 3)
		)
	}
}
