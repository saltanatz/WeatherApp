//
//  ContentView.swift
//  WeatherApp
//
//  Created by Saltanat on 25.05.2024.
//

import SwiftUI

struct ContentView: View {
	@StateObject var locationManager = LocationManager()
	var weatherManager = WeatherManager()
	@State var weather: ResponseBody?
    var body: some View {
        VStack {
			if let location = locationManager.location {
				if let weather = weather {
					WeatherView(weather: weather)
				} else {
					LoadingView()
						.task {
							do {
								weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longtitude: location.longitude)
							} catch {
								print("Error getting weather: \(error)")
							}
						}
				}
			} else {
				if locationManager.isLoading {
					LoadingView()
				} else {
					WelcomeView()
						.environmentObject(locationManager)
				}
			}
        }
		.background(Color(hue: 0.573, saturation: 0.556, brightness: 1.0))
		
		
    }
}

#Preview {
    ContentView()
}
