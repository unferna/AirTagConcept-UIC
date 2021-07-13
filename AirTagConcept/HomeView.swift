//
//  HomeView.swift
//  AirTagConcept
//
//  Created by Fernando Florez on 10/07/21.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedItem = 0
    @State var devices: [DeviceItem] = []
    @State var selectedType: DeviceItemType = .device
    @State private var selectedDevice: DeviceItem!
    
    var filtered: [DeviceItem] {
        devices.filter { $0.type == selectedType}
    }
    
    private let grid = [
        GridItem(.adaptive(minimum: 320, maximum: 350)),
    ]
    
    let backgroundColor = Color.gray.opacity(0.1)
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                ScrollView(showsIndicators: false) {
                    HStack {
                        Text("Browse")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding()
                        
                        Spacer()
                    }
                    
                    selectorCollection
                    
                    itemList
                    Spacer()
                }
                
                tabbar
                        
            }
        }
        .navigationBarHidden(true)
    }
    
    var selectorCollection: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                Button(action: {}) {
                    VStack {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.gray)
                            .font(.system(size: 20))
                    }
                    .frame(width: 60, height: 100)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    selectedType = .device
                }) {
                    ButtonSelector(isSelected: selectedType == .device, name: "Devices", icon: "laptopcomputer.and.iphone")
                    
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    selectedType = .item
                }) {
                    ButtonSelector(isSelected: selectedType == .item, name: "Items", icon: "arkit")
                }
            }
            .padding()
        }
    }
    
    var itemList: some View {
        VStack {
            HStack(spacing: -10) {
                Text("Devices")
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding()

                Text(String(filtered.count))
                    .font(.title3)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            
            LazyVGrid(columns: grid, alignment: .center, spacing: 30) {
                ForEach(filtered, id: \.id) { device in
                    DeviceItemCell(device: device, deviceToSelect: $selectedDevice)
                        .fullScreenCover(item: $selectedDevice, onDismiss: {}, content: {
                            MapView(deviceItem: $0)
                        })
                }
            }
        }
    }
    
    var tabbar: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            HStack(spacing: 50) {
                Image(systemName: "location")
                Image(systemName: "laptopcomputer.and.iphone")
                Image(systemName: "arkit")
                Image(systemName: "circle.grid.2x2")
                Image(systemName: "switch.2")
            }
        }
        .frame(height: 60)
    }
}

struct ButtonSelector: View {
    var isSelected: Bool
    var name: String
    var icon: String
    
    var body: some View {
        VStack {
            Text(name)
                .font(.system(size: 14))
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .foregroundColor(
                    isSelected ? .white : Color.gray.opacity(0.9)
                )
            
            Image(systemName: icon)
                .foregroundColor(
                   isSelected ? .white : Color.gray.opacity(0.6)
                )
                .font(.system(size: 25))
        }
        .frame(width: 100, height: 100)
        .background(
            isSelected ? Color.black : Color.white
        )
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(devices: DeviceItem.all)
    }
}

extension DeviceItem {
    static let all: [DeviceItem] = [
        DeviceItem(
            id: UUID(),
            name: "Jake's Scooter",
            carDistanceTime: 8 * 60,
            walkingDistanceTime: 13 * 60,
            batteryCharge: 50,
            distance: "832.9 ft",
            emoji: "🛵",
            type: .device
        ),
        DeviceItem(
            id: UUID(),
            name: "My AirPods Max",
            carDistanceTime: 0,
            walkingDistanceTime: 0,
            batteryCharge: 100,
            distance: "100 ft",
            emoji: "🎧",
            type: .device
        ),
        DeviceItem(
            id: UUID(),
            name: "Watch",
            carDistanceTime: 0,
            walkingDistanceTime: 0,
            batteryCharge: 100,
            distance: "20 ft",
            emoji: "⌚️",
            type: .device
        ),
        DeviceItem(
            id: UUID(),
            name: "House Keys",
            carDistanceTime: 0,
            walkingDistanceTime: 90,
            batteryCharge: 0,
            distance: "90 ft",
            emoji: "🔑",
            type: .item
        ),
        DeviceItem(
            id: UUID(),
            name: "Car",
            carDistanceTime: 0,
            walkingDistanceTime: 70,
            batteryCharge: 0,
            distance: "120 ft",
            emoji: "🚗",
            type: .item
        ),
    ]
}
