//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Saltanat on 25.05.2024.
//

import SwiftUI
import WebKit

struct GIFView: UIViewRepresentable {
	let url: URL
	
	func makeUIView(context: Context) -> WKWebView {
		let webView = WKWebView()
		webView.isUserInteractionEnabled = false
		return webView
	}
	
	func updateUIView(_ uiView: WKWebView, context: Context) {
		let request = URLRequest(url: url)
		uiView.load(request)
	}
}

struct WeatherView: View {
	var weather: ResponseBody
	
    var body: some View {
		ZStack(alignment: .leading) {
			VStack {
				VStack(alignment: .leading, spacing: 5) {
					Text(weather.name)
						.bold().font(.title)
					
					Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
						.fontWeight(.light)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				Spacer()
				
				VStack {
					HStack {
						VStack(spacing:20) {
							Image(systemName: "sun.max").font(.system(size: 40))
							
							Text(weather.weather[0].main)
						}
						.frame(width: 150, alignment: .leading)
						
						Spacer()
						
						Text(weather.main.feelsLike.roundDouble() + "°").font(.system(size: 100)).fontWeight(.bold).padding()
					}
					Spacer()
						.frame(height:5)
					
					GIFView(url: URL(string: "https://i.giphy.com/1Fm7jEapE18HwS6fkT.webp")!)
						.frame(width: 300, height: 300)
						.cornerRadius(10)
					Spacer()
				}
			}
			.padding()
			.frame(maxWidth: .infinity, alignment: .leading)
			
			VStack {
				Spacer()
				
				VStack(alignment: .leading, spacing: 20){
					Text("Weather now").bold().padding(.bottom)
					
					HStack {
						WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + "°"))
						Spacer()
						WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
					}
					HStack {
						WeatherRow(logo: "wind", name: "Wind Speed", value: (weather.wind.speed.roundDouble() + "m/s"))
						Spacer()
						WeatherRow(logo: "humidity", name: "humidity", value: (weather.main.humidity.roundDouble() + "%"))
					}
					
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding()
				.padding(.bottom, 20)
				.foregroundColor(Color(hue: 0.573, saturation: 0.963, brightness: 0.701))
				.background(.white)
				.cornerRadius(20, corners: [.topLeft, .topRight])
			}
		}
		.edgesIgnoringSafeArea(.bottom)
		.background(Color(hue: 0.573, saturation: 0.556, brightness: 1.0))
    }
}

struct WeatherView_Preview: PreviewProvider {
	static var previews: some View {
		WeatherView(weather: previewWeather)
	}
}

//#Preview {
//    WeatherView()
//}
