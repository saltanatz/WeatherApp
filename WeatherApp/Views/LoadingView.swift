//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Saltanat on 25.05.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
			.progressViewStyle(CircularProgressViewStyle(tint: .black))
			.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    LoadingView()
}
