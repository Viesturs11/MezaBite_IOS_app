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
                
                // 🖼 BILDE
                Image("stropi")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(16)
                
                Text("Kontakti")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("TextPrimary"))
                
                // 📇 KONTAKTU BLOKS
                VStack(spacing: 12) {
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color("PrimaryColor"))
                        
                        Link("info@mezabite.lv",
                             destination: URL(string: "mailto:info@mezabite.lv")!)
                            .foregroundColor(Color("TextPrimary"))
                    }
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(Color("PrimaryColor"))
                        
                        Link("26495921",
                             destination: URL(string: "tel:26495921")!)
                            .foregroundColor(Color("TextPrimary"))
                    }
                    
                    HStack(alignment: .top) {
                        Image(systemName: "location.fill")
                            .foregroundColor(Color("PrimaryColor"))
                        
                        Text("\"Saules\", Burtnieku pagasts,\nValmiera novads, Latvija")
                            .foregroundColor(Color("TextPrimary"))
                    }
                }
                .padding()
                .background(Color("CardColor"))
                .cornerRadius(16)
                
                // 🗺 KARTE BLOKĀ
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Atrašanās vieta")
                        .font(.headline)
                        .foregroundColor(Color("TextPrimary"))
                    
                    MapView()
                }
                .padding()
                .background(Color("CardColor"))
                .cornerRadius(16)
                
                Spacer()
            }
            .padding()
        }
        .background(Color("BackgroundColor").ignoresSafeArea()) 
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
                    .foregroundColor(Color("PrimaryColor"))
            }
        }
        .frame(height: 220)
        .cornerRadius(16)
    }
}

struct LocationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

private var locationItem: LocationItem {
    LocationItem(coordinate: CLLocationCoordinate2D(latitude: 57.6197, longitude: 25.3491))
}
