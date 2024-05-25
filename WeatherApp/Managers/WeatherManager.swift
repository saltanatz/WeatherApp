//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Saltanat on 25.05.2024.
//

import Foundation
import CoreLocation

class WeatherManager {
	func getCurrentWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) async throws -> ResponseBody {
		guard let url = URL(string: "http://api.openweathermap.org/geo/1.0/reverse?lat=\(latitude)}&lon=\(longtitude)&limit={limit}&appid=\("3bd784634b13316fb7102a8745e3edba")&units=metric") else {fatalError("Mussing URL")}
		let urlRequest = URLRequest(url: url)
		
		let (data, response) = try await URLSession.shared.data(for: urlRequest)
		guard(response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error fetching weather data")}
		let decodeData = try JSONDecoder().decode(ResponseBody.self, from: data)
		
		return decodeData
	}
}
struct ResponseBody: Decodable {
	var coord: CoordinatesResponse
	var weather: [WeatherResponse]
	var main: MainResponse
	var name: String
	var wind: WindResponse
	
	struct CoordinatesResponse: Decodable {
		var lon: Double
		var lat: Double
	}
	
	struct WeatherResponse: Decodable {
		var id: Double
		var main: String
		var description: String
		var icon: String
	}
	struct MainResponse: Decodable {
			var temp: Double
			var feels_like: Double
			var temp_min: Double
			var temp_max: Double
			var pressure: Double
			var humidity: Double
		}
		
		struct WindResponse: Decodable {
			var speed: Double
			var deg: Double
		}
	}

extension ResponseBody.MainResponse {
	var feelsLike: Double { return feels_like }
	var tempMin: Double { return temp_min }
	var tempMax: Double { return temp_max }
}
