//
//  FavoriteLocationView.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 5.05.2024.
//

import SwiftUI

struct FavoriteLocationView: View {
	@StateObject var viewModel: FavoriteLocationViewModel
	
	var body: some View {
		VStack {
			Text("Hava Durumu")
				.font(.title)
				.padding(.top)
			
			SearchBar() // Arama kutusu
			
			Divider()
				.padding(.top)
			
			ScrollView {
				ForEach(viewModel.locations, id: \.name) { location in
					LocationCard(location: location)
						.padding(.horizontal)
						.padding(.bottom)
				}
			}
		}
	}
}


//arama yapısı
struct SearchBar: View {
	@State private var SearchText = ""
	
	var body: some View {
		/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
	}
}



// bir location card eklemeliyim
struct LocationCard: View {
	var location: Location
	
	
	var body: some View {
		/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
	}
}

#Preview {
	FavoriteLocationView()
}
