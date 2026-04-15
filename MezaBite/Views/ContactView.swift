//
//  ContactView.swift
//  MezaBite
//
//  Created by Viesturs Karlivans on 14/04/2026.
//

import SwiftUI
import MapKit

struct ContactView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // 🖼 Bilde
                Image("stropi")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(radius: 5)
                
                Text("Kontakti")
                    .font(.title)
                    .bold()
                
                // 📧 Epasts
                HStack {
                    Image(systemName: "envelope")
                    Link("info@mezabite.lv", destination: URL(string: "mailto:info@mezabite.lv")!)
                }
                
                // 📞 Telefons
                HStack {
                    Image(systemName: "phone")
                    Link("26495921", destination: URL(string: "tel:26495921")!)
                }
                
                // 📍 Adrese
                HStack(alignment: .top) {
                    Image(systemName: "location")
                    Text("\"Saules\", Burtnieku pagasts,\nValmiera novads, Latvija")
                }
                
                // 🗺 KARTE
                MapView()
                
                Spacer()
            }
            .padding()
        }
    }
}

struct MapView: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 57.6197, longitude: 25.3491),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    let location = CLLocationCoordinate2D(latitude: 57.6197, longitude: 25.3491)
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [locationItem]) { item in
            MapAnnotation(coordinate: item.coordinate) {
                Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)
            }
        }
        .frame(height: 220)
        .cornerRadius(12)
    }
}

struct LocationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

private var locationItem: LocationItem {
    LocationItem(coordinate: CLLocationCoordinate2D(latitude: 57.6197, longitude: 25.3491))
}
