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
				ContentView(weatherViewModel: WeatherViewModel())
			} else {
				LottieView(name: "animation3", loopMode: .playOnce)
					.frame(width: 200, height: 200)
					.onAppear {
						//kuyruğa ekleyerek 3 saniye bekletme
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
