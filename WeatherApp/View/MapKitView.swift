//
//  MapKitView.swift
//  WeatherApp
//
//  Created by Ahmet Emin Yalçınkaya on 6.05.2024.
//

import SwiftUI
import MapKit

struct MapKitView: UIViewRepresentable {

	@ObservedObject var viewModel: FavoriteLocationViewModel

	func makeUIView(context: Context) -> MKMapView {
		let mapView = MKMapView()
		
		let kyotoLocation = CLLocation(latitude: 35.0116, longitude: 135.7681)
		let kyotoAnnotation = MKPointAnnotation()
		kyotoAnnotation.coordinate = kyotoLocation.coordinate
		kyotoAnnotation.title = "Kyoto"
		
		mapView.addAnnotation(kyotoAnnotation)
		
		let region = MKCoordinateRegion(center: kyotoLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
		mapView.setRegion(region, animated: true)
		
		return mapView
	}


	
	

	
	
	
	func updateUIView(_ uiView: MKMapView, context: Context) {
		/*
		//Favoriler pinlenmeli
		viewModel.favorites.forEach { location in
			let annotation = MKPointAnnotation()
			//location modelinden coordinate almalıyım
			annotation.title = location.name
			uiView.addAnnotation(annotation)
		 */
		
		}
	 

	
	
	
	}



