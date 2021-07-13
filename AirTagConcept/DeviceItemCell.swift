//
//  DeviceItemCell.swift
//  AirTagConcept
//
//  Created by Fernando Florez on 10/07/21.
//

import SwiftUI

enum DeviceItemType: Int {
    case device = 0
    case item = 1
}

struct DeviceItem: Identifiable {
    var id: UUID
    var name: String
    var carDistanceTime: Int
    var walkingDistanceTime: Int
    var batteryCharge: Int
    var distance: String
    var emoji: String
    var type: DeviceItemType
}

struct DeviceItemCell: View {
    var device: DeviceItem
    @Binding var deviceToSelect: DeviceItem?
    
    var batteryIconString: String {
        if device.batteryCharge == 100 {
            return "battery.100"
        
        } else if device.batteryCharge >= 25 {
            return "battery.25"
        }
        
        return "battery.0"
    }
    
    var batteryColor: Color {
        if device.batteryCharge >= 60 {
            return .green
        
        } else if device.batteryCharge >= 20 {
            return .yellow
        }
        
        return .red
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Color.clear.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text(device.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        
                    Spacer()
                }.padding()
                
                HStack(spacing: 8) {
                    Image(systemName: "car")
                    Text( getTimeFrom(seconds: device.carDistanceTime) )
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    
                    Image(systemName: "figure.walk")
                    Text( getTimeFrom(seconds: device.walkingDistanceTime) )
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    
                    Image(systemName: batteryIconString)
                        .foregroundColor(batteryColor)
                    Text("\(device.batteryCharge)%")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding(.horizontal, 5)
                
                HStack {
                    Button(action: {
                        deviceToSelect = device
                    }) {
                        HStack {
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(.blue)
                            
                            Text("Play Sound")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    
                    }.buttonStyle(PlainButtonStyle())
                    
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "location.circle.fill")
                                .foregroundColor(.green)
                            Text(device.distance)
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }.buttonStyle((PlainButtonStyle()))
                    
                }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 3)
            
            Text(device.emoji)
                .font(.system(size: 80))
                .offset(x: -25, y: -65)
        }
    }
    
    func getTimeFrom(seconds: Int) -> String {
        var result = ""
        
        if seconds >= 3600 {
            let totalTime = CGFloat(CGFloat(seconds) / 60.0 / 60.0)
            let totalIntTime = Int(totalTime)
            
            if totalTime > CGFloat(totalIntTime) {
                result = String(format: "%.2f", totalTime) + " hours"
            
            } else {
                result = "\(totalIntTime) hour" + (totalIntTime > 1 ? "s" : "")
            }
        
        } else if seconds > 60 {
            let totalTime = CGFloat(CGFloat(seconds) / 60.0)
            let totalIntTime = Int(totalTime)
            
            if totalTime > CGFloat(totalIntTime) {
                result = String(format: "%.2f", totalTime) + " mins"
            
            } else {
                result = "\(totalIntTime) min" + (totalIntTime > 1 ? "s" : "")
            }
            
        } else {
            result = "\(seconds) sec"
        }
        
        return result
    }
}

struct DeviceItemCell_Previews: PreviewProvider {
    static let testDevice = DeviceItem(
        id: UUID(),
        name: "Jake's Scooter",
        carDistanceTime: 8 * 60,
        walkingDistanceTime: 13 * 60,
        batteryCharge: 50,
        distance: "832.9 ft",
        emoji: "🛵",
        type: .item
    )
    
    static var previews: some View {
        DeviceItemCell(device: testDevice, deviceToSelect: .constant(nil))
            .previewLayout(.fixed(width: 359, height: 200))
    }
}
