//
//  ContentView.swift
//  ShootAR
//
//  Created by Ziady Mubaraq on 22/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ARViewContainer()
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
