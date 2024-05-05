//
//  SplashScreenView.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 5.05.2024.
//

import SwiftUI

struct SplashScreenView: View {
	@State private var shouldShowContentView = false
	
	var body: some View {
		VStack {
			if shouldShowContentView {
				ContentView(weatherViewModel: WeatherViewModel()) // 3 saniye sonra ContentView ekranını göster
			} else {
				LottieView(name: "animation3", loopMode: .playOnce)
					.frame(width: 200, height: 200)
					.onAppear {

						DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
							withAnimation {
								shouldShowContentView = true
							}
						}
					}
			}
		}
	}
}

struct SplashScreenView_Previews: PreviewProvider {
	static var previews: some View {
		SplashScreenView()
	}
}
