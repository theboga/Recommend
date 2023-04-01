//
//  ActorPeliculasView.swift
//  Recommend
//
//  Created by Ignacio Bogarin on 28/05/22.
//

import SwiftUI
import Kingfisher

struct ActorPeliculasView: View {
    @ObservedObject var losDetalles = ViewModel()
    var id: Int
    var actor: String
    var foto: String
    
    var body: some View {
        ZStack{
            Color("Color-Marino")
                .ignoresSafeArea()
                .onAppear(){
                    perform: do{
                        losDetalles.obtenerActorPeliculas(myId: id)
                        //print("Los detalles::\(losDetalles.actoresPeliculasInfo)")
                        
                        //losDetalles.obtenerActorDetalle(myId: id)
                        //print("Los detalles::\(myData)")
                    }
                }
            VStack{
                let columnPelis:[GridItem] = [
                    GridItem(.flexible(), spacing: 10, alignment: nil),
                    GridItem(.flexible(), spacing: 10, alignment: nil)
                ]
                ScrollView{
                    
                    KFImage(URL(string: "https://image.tmdb.org/t/p/w440_and_h660_face\(foto)")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 450, alignment: .top)
                        .clipShape(Rectangle())
                        .ignoresSafeArea()
                    Text(actor)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Peliculas")
                        .foregroundColor(.white)
                    
                    
                    LazyVGrid(columns: columnPelis) {
                        ForEach(losDetalles.actoresPeliculasInfo, id:\.self){
                            peli in
                            let fot = peli.poster_path ?? "x"
                            if fot != "x" {
                                VStack{
                                    KFImage(URL(string: "https://image.tmdb.org/t/p/w440_and_h660_face\(peli.poster_path!)")!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    Text("\(peli.title)")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .truncationMode(.tail)
                                    Text("\(peli.character ?? "")")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .truncationMode(.tail)
                                }.padding(3)
                            }
                        }
                    }
                }
                
            } //end stack
            .ignoresSafeArea()
            Spacer(minLength: 44)
        }
    }
}

struct ActorPeliculasView_Previews: PreviewProvider {
    static var previews: some View {
        ActorPeliculasView(id: 1136406, actor:"Tom Holland", foto:"/2qhIDp44cAqP2clOgt2afQI07X8.jpg")
    }
}
