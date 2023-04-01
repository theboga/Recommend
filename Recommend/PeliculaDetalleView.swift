//
//  PeliculaDetalleView.swift
//  Recommend
//
//  Created by Ignacio Bogarin on 07/05/22.
//

import SwiftUI
import Kingfisher

struct PeliculaDetalleView: View {
    @ObservedObject var losActores = ViewModel()
    
    var adult: Bool
    var backdrop_path: String
    var genre_ids: [Int]
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Float
    var poster_path: String
    var release_date: String
    var title: String
    var video: Bool
   @State var vote_average: Float
    var vote_count: Int
    
    @State var isCoverComplete = false
    
    @State var genero = [
        28:"Acción",12:"Aventura",16:"Animación",
        35:"Comedia",80:"Crimen",99:"Documental",
        18:"Drama",10751:"Familia",14:"Fantasía",
        36:"Historia",27:"Terror",10402:"Música",
        9648:"Misterio",10749:"Romance",878:"Ciencia ficción",
        10770:"Película de TV",53:"Suspense",
        10752:"Bélica",37:"Western"
        ]

    
    
    
    var body: some View {
        ZStack{
            Color("Color-Marino").ignoresSafeArea()
                .onAppear(){
                perform: do {
                    losActores.obtenerActores(myId: id)
                    //print("Los Actores-> \(losActores.actoresInfo)")
                    
                    losActores.obtenerVideos(myId: id)
                    //print("Los videos-> \(losActores.videosInfo)")
                    
                    losActores.obtenerSimilares(myId: id)
                    print("Pelis similares:: \(losActores.similarInfo)")
                    }
                }
            ScrollView{
                ZStack {
                    KFImage(URL(string: "https://image.tmdb.org/t/p/w440_and_h660_face\(backdrop_path)")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 400, alignment: .top)
                        .clipShape(Rectangle())
                    .ignoresSafeArea()
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [.clear, Color("Color-Marino")]), startPoint: .top, endPoint: .bottom))
                }
                
                HStack{
                    Button {
                        isCoverComplete = true
                        print("Abrir pantalla")
                    } label: {
                        ZStack{
                            KFImage(URL(string: "https://image.tmdb.org/t/p/w440_and_h660_face\(poster_path)")!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 250)
                                .clipShape(Rectangle())
                                .shadow(color: .black, radius: 20, x: 2, y: 2)
                                .padding(.top,-200)
                            Image(systemName: "square.dashed.inset.filled")
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 3, x: 2, y: 2)
                                .opacity(0.6)
                                .frame( maxWidth: .infinity,  alignment: .leading)
                                .padding(.leading,25)
                        }
                    }

                        Spacer()
                    VStack{
                        /*
                        if let ye = release_date.split(separator: "-").map(String.init) {
                            Text("Año \(ye[0])")
                                .foregroundColor(.white)
                        } else {
                            Text("Año \(release_date)")
                                .foregroundColor(.white)
                        } */
                        
                        MyProgressBar(progress: $vote_average)
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.white)
                            
                        if release_date.contains("-") {
                            Text(Image(systemName: "calendar")).foregroundColor(.white) + Text(" \(String(release_date[..<release_date.firstIndex(of: "-")!]))")
                                .foregroundColor(.white)
                        } else {
                            Text(Image(systemName: "calendar")).foregroundColor(.white) + Text("\(release_date)")
                                .foregroundColor(.white)
                        }
                        Text(Image(systemName: "hand.thumbsup")).foregroundColor(.white) + Text(" \(vote_count)")
                            .foregroundColor(.white)
                        Text("Popularidad \(vote_average)")
                            .foregroundColor(.white)
                    }.padding(.top,0)
                }.padding()
                HStack{
                    ForEach(genre_ids, id: \.self){
                        gen in
                        Text(genero[gen] ?? genero[gen]!)
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                }.padding()
                
                VStack{
                    Text("\(title)")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("\(overview)")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding()
                    Text("Título Original")
                        .foregroundColor(.white)
                        
                    Text("\(original_title)")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom,50)
                    let todosLosVideos = losActores.videosInfo
                    let todosLosVideosFiltrados = losActores.videosInfo.filter({$0.type.lowercased() == "trailer"})
                    if todosLosVideosFiltrados.count > 0 {
                        Text("Video Trailer")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.bold)
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 200, height: 3, alignment: .center)
                            .foregroundColor(Color("Color-Blue-Gray"))
                            .padding(.bottom,10)
                    }
                    HStack{
                        
                        let rowsVideo:[GridItem] = [
                            GridItem(.flexible(), spacing: 3, alignment: nil)
                        ]
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rowsVideo) {
                                ForEach(todosLosVideosFiltrados, id:\.self){
                                    myVideo in
                                    VStack{
                                        VideoView(videoID: "\(myVideo.key)")
                                            .frame(width: 200, height: 100)
                                            .cornerRadius(12)
                                        Text("\(myVideo.name)")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .lineLimit(2)
                                            .truncationMode(.tail)
                                            .frame(width: 160, height: 20, alignment: .center)
                                    }.padding(5)
                                        .padding(.bottom,10)
                                }
                            }
                        }
                    }
                }.padding(10)
                
                
                let todosLosActores = losActores.actoresInfo
                HStack{
                    let rowsActor:[GridItem] = [
                        GridItem(.flexible(), spacing: 5, alignment: nil)
                    ]
                    Text("Actores")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.leading,3)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 3, height: 120, alignment: .center)
                        .foregroundColor(Color("Color-Blue-Gray"))
                    
                    
                    ScrollView(.horizontal){
                        LazyHGrid(rows: rowsActor) {
                            ForEach(todosLosActores, id: \.self) {
                                myActor in
                                
                                if let imagen = myActor.profile_path {
                                    NavigationLink(destination: ActorPeliculasView(id:myActor.id, actor:myActor.name, foto:imagen)) {
                                            VStack{
                                                KFImage(URL(string: "https://image.tmdb.org/t/p/w440_and_h660_face\(imagen)")!)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .clipShape(Circle())
                                                .frame(width: 80, height: 80)
                                                
                                                Text("\(myActor.name)")
                                                        .foregroundColor(.white)
                                                        .font(.caption)
                                                        .fontWeight(.bold)
                                                        .lineLimit(1)
                                                        .frame(width: 130)
                                                        .truncationMode(.tail)
                                                Text("\(myActor.character)")
                                                        .foregroundColor(.white)
                                                        .font(.caption2)
                                                        .fontWeight(.light)
                                                        .lineLimit(1)
                                                        .frame(width: 130)
                                                        .truncationMode(.tail)
                                            }
                                    }
                                    
                                }
                                
                            }
                        }
                        
                    }
                }
                VStack{
                    Text("Peliculas Similares")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 200, height: 3, alignment: .center)
                        .foregroundColor(Color("Color-Blue-Gray"))
                        .padding(.bottom,10)
                    let todosLosSimi = losActores.similarInfo
                    let todosLosSimilares = todosLosSimi.filter({$0.poster_path.isEmpty == false})
                    
                    
                    HStack{
                        let rowsSimilar:[GridItem] = [
                            GridItem(.flexible(), spacing: 5, alignment: nil)
                        ]
                        ScrollView(.horizontal){
                            LazyHGrid(rows: rowsSimilar) {
                                ForEach(todosLosSimilares, id: \.self){
                                    similar in
                                    
                                    NavigationLink(destination: PeliculaDetalleView(adult: similar.adult, backdrop_path: similar.backdrop_path ?? "/5UX6M0aEphiW6Xmy5rpYX75glbo.jpg", genre_ids: similar.genre_ids, id: similar.id, original_language: similar.original_language, original_title: similar.original_title, overview: similar.overview, popularity: similar.popularity, poster_path: similar.poster_path, release_date: similar.release_date ?? "", title: similar.title, video: similar.video, vote_average: similar.vote_average, vote_count: similar.vote_count)) {
                                        VStack{
                                            KFImage(URL(string: "https://image.tmdb.org/t/p/w440_and_h660_face\(similar.poster_path)")!)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 140, height: 200)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                            Text("\(similar.title)")
                                                .font(.caption2)
                                                .foregroundColor(.white)
                                                .frame(width: 110)
                                                .truncationMode(.tail)
                                            
                                        }
                                    } // end Navigation Link
                                }
                            }
                        }
                    }
                    
                       
                }.padding(.top,20)
                
                    
                Spacer(minLength: 82.0)
            }.ignoresSafeArea()
                
        }
        .sheet(isPresented: $isCoverComplete) {
            ZStack{
                Color("Color-Marino")
                VStack{
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 80, height: 5, alignment: .center)
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                    Spacer()
                    KFImage(URL(string: "https://image.tmdb.org/t/p/w440_and_h660_face\(poster_path)")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Rectangle())
                        .shadow(radius: 45)
                    Spacer()
                    Button {
                        isCoverComplete = false
                    } label: {
                        
                        HStack{
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.gray)
                            Text("Cerrar")
                                .foregroundColor(.gray)
                        }
                        .padding(.bottom, 10)
                    }

                }
            }
        } // end .sheet
    }
}


struct PeliculaDetalleView_Previews: PreviewProvider {
    static var previews: some View {
        PeliculaDetalleView(adult: false, backdrop_path: "/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg", genre_ids: [
            28,
            12,
            878
          ], id: 634649, original_language: "en", original_title: "Spider-Man: No Way Home", overview: "Peter Parker es desenmascarado y ya no puede separar su vida normal de los altos riesgos de ser un súper héroe. Cuando pide ayuda al Doctor Strange para recuperar su secreto, el hechizo crea un agujero en su mundo, liberando a los villanos más poderosos que han luchado con cualquier Spider-Man, en cualquier universo. Ahora Peter debe de superar su reto más grande, que no solo alterara su propio futuro pero el del multiverso, forzándolo a descubrir lo que realmente significa ser Spider-Man.", popularity: 4233.932, poster_path: "/osYbtvqjMUhEXgkuFJOsRYVpq6N.jpg", release_date: "2021-12-15", title: "Spider-Man: Sin camino a casa", video: false, vote_average: 8.1, vote_count: 12165)
    }
}
