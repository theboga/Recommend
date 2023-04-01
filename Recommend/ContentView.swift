//
//  ContentView.swift
//  Recommend
//
//  Created by Ignacio Bogarin on 29/04/22.
//

import SwiftUI

struct ContentView: View {
    @State var titule = "Entrar"
    @State var idioma:Bool = false
    @State var isHomeActive: Bool = false
    @State var tabSeleccionado:Int = 4
    var body: some View {
        TabView(selection: $tabSeleccionado, content: {
            Text("Pantalla Series")
                .fontWeight(.bold)
                .font(.title3)
                .tabItem {
                    Image(systemName: "play.circle")
                    Text("Series")
                }.tag(1)
            
            Text("Pantalla Peliculas")
                .fontWeight(.bold)
                .font(.title3)
                .tabItem {
                    Image(systemName: "play.tv")
                    Text("Peliculas")
                }.tag(2)
            
            Text("Pantalla recomendaciones")
                .fontWeight(.bold)
                .font(.title3)
                .tabItem {
                    Image(systemName: "bolt.heart")
                    Text("Recomendar")
                }.tag(3)
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Inicio")
                }.tag(4)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Setings")
                }.tag(5)
        })
        .accentColor(.white)
    }
    init(){
        UITabBar.appearance().backgroundColor = UIColor(Color("Color-Tab"))
        UITabBar.appearance().isTranslucent = true
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
