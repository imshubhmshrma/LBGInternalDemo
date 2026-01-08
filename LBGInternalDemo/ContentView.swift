//
//  ContentView.swift
//  LBGInternalDemo
//
//  Created by Shubham Sharma on 26/12/25.
//

import SwiftUI

struct ContentView: View {
    let service = UserService() 
    var body: some View {
    
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        } 
        .padding()
    }
    
    
   
}

//#Preview {
//    ContentView()
//}
