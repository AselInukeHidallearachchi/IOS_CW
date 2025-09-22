//
//  NetworkStatusCard.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import SwiftUI

// Displays a warning message when the device is offline.
struct NetworkStatusCard: View {
    @EnvironmentObject var networkVM: NetworkMonitor // Observes the network status.

    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [Color.red.opacity(0.9), Color.orange.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                
                Image(systemName: "wifi.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)

                Text("No Internet Connection")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("It looks like you're offline. Please check your connection and try again.")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

            }
            .padding(30)
        }
    }
}

#Preview {
    NetworkStatusCard()
}

