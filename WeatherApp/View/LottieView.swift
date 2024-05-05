//
//  LottieView.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 5.05.2024.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
	var name: String
	let loopMode: LottieLoopMode
	let animationSpeed: CGFloat
	
	
	init(name: String, loopMode: LottieLoopMode = .playOnce, animationSpeed: CGFloat = 1) {
		self.name = name
		self.loopMode = loopMode
		self.animationSpeed = animationSpeed
	}
	
	func makeUIView(context: Context) ->  Lottie.LottieAnimationView {
		
		let animationView = Lottie.LottieAnimationView(name:name)
		
		animationView.loopMode = loopMode
		animationView.animationSpeed = animationSpeed
		animationView.play()
		return animationView
		
		


		

	}

	func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {
		// Update the view if needed
	}
}


