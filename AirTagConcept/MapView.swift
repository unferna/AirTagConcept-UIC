//
//  MapView.swift
//  AirTagConcept
//
//  Created by Fernando Florez on 11/07/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
        span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
    )
    
    var deviceItem: DeviceItem
    
    @Environment(\.presentationMode) var presentationMode
    
    var batteryIconString: String {
        if deviceItem.batteryCharge == 100 {
            return "battery.100"
        
        } else if deviceItem.batteryCharge >= 25 {
            return "battery.25"
        }
        
        return "battery.0"
    }
    
    var batteryColor: Color {
        if deviceItem.batteryCharge >= 60 {
            return .green
        
        } else if deviceItem.batteryCharge >= 20 {
            return .yellow
        }
        
        return .red
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        
                    }) {
                        VStack {
                            Image(systemName: "circle.grid.2x2")
                                .resizable()
                                .frame(width: 25, height: 25)
                            
                        }
                        .frame(width: 50, height: 50, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    Button(action: {
                        
                    }) {
                        VStack {
                            (
                                Text("New York")
                                    .font(.system(size: 16).weight(.bold))
                                
                                + Text(" City")
                                    .font(.system(size: 16).weight(.bold))
                                    .foregroundColor(.gray)
                            )
                            .padding()
                            
                        }
                        .frame(height: 50, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    Button(action: {
                        
                    }) {
                        VStack {
                            Image(systemName: "location.fill")
                        }
                        .frame(width: 50, height: 50, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                    }
                    .buttonStyle(PlainButtonStyle())
                }.padding()
                Spacer()
                
                ZStack {
                    Color.white
                        .cornerRadius(40)
                        .edgesIgnoringSafeArea(.bottom)
                        .shadow(radius: 10)
                        
                    VStack {
                        Text(deviceItem.emoji)
                            .font(.system(size: 100))
                        
                        Text(deviceItem.name)
                            .fontWeight(.bold)
                            .padding(.bottom, 16)
                        
                        
                        VStack {
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .green, .yellow, .orange]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .mask(
                                Image("soundSpectrum")
                                    .resizable()
                            )
                        }
                        .frame(height: 45)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 16)
                        
                        
                        Text("Start speaking to assign a name to the AirTag with your voice. A category wiill be assigned automatically.")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        VStack {
                            Button("Finish") {
                                presentationMode.wrappedValue.dismiss()
                            }
                            .frame(maxWidth: .infinity, maxHeight: 56)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(15)
                            .font(.system(size: 16).weight(.bold))
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    VStack {
                        Image(systemName: batteryIconString)
                            .foregroundColor(batteryColor)
                        
                        Text("\(deviceItem.batteryCharge)%")
                            .font(.system(size: 12))
                    }
                    .offset(x: 150, y: -100)
                    
                }
                .frame(width: .infinity, height: 350)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static let testDevice = DeviceItem(
        id: UUID(),
        name: "My AirPods Max",
        carDistanceTime: 0,
        walkingDistanceTime: 0,
        batteryCharge: 100,
        distance: "100 ft",
        emoji: "🎧",
        type: .device
    )
    static var previews: some View {
        MapView(deviceItem: testDevice)
    }
}
