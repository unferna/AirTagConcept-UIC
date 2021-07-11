//
//  ContentView.swift
//  AirTagConcept
//
//  Created by Fernando Florez on 10/07/21.
//

import SwiftUI

struct ContentView: View {
    @State private var navigation = false
    @State private var devices = DeviceItem.all
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        Image("airtagLogo")
                            .resizable()
                            .frame(width: 250, height: 250)
                            
                    }
                    .padding()
                    .padding(.top, 80)
                    
                    Spacer()
                    
                    VStack {
                        Text("Ping it. Find it.\nAirTag.")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                        
                        Text("Lose your knack for losing things.")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    NavigationLink(destination: HomeView(devices: devices), isActive: $navigation) {
                        HStack {
                            Text("Get started")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(maxHeight: .infinity)
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                                .font(.system(size: 25))
                                .padding(.trailing, 20)
                        }
                        .background(Color.white)
                        .frame(height: 56)
                        .cornerRadius(16)
                        .padding(.horizontal, 20)
                    }.buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .navigationTitle("")
            .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
