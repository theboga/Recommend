//
//  HomeView.swift
//  Recommend
//
//  Created by Ignacio Bogarin on 29/04/22.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @ObservedObject var todasLasPelis = ViewModel()
    
    @State var adult: Bool = false
    @State var backdrop_path: String = ""
    @State var genre_ids: [Int] = []
    @State var id: Int = 0
    @State var original_language: String = ""
    @State var original_title: String = ""
    @State var overview: String = ""
    @State var popularity: Float = 0.0
    @State var poster_path: String = ""
    @State var release_date: String = ""
    @State var title: String = ""
    @State var video: Bool = false
    @State var vote_average: Float = 0.0
    @State var vote_count: Int = 0
    
    @State var serverPeticionMain:Bool = false
    @State var peliculaDetalleIsActive:Bool = false
    
    
    let formaGrid = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
            NavigationView{
            ZStack{
                Color("Color-Marino").ignoresSafeArea()
                    .onAppear(
                        perform: {
                            if !serverPeticionMain {
                                print("Las Pelis-> \(todasLasPelis.pelisInfo)")
                                serverPeticionMain = true
                            }
                        }
                    )
                    
                VStack{
                    Image("logo-recommend")
                    ScrollView{
                        Text("Most Popular")
                            .font(.title3)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .frame( maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        ZStack{
                            
                            
                            let n = todasLasPelis.pelisInfo.prefix(1)
                            ForEach(n, id: \.self){
                                miPeli in
                                KFImage(URL(string: "https://image.tmdb.org/t/p/w440_and_h660_face\(miPeli.backdrop_path ?? "/5UX6M0aEphiW6Xmy5rpYX75glbo.jpg")"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 400, alignment: .center)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .background(LinearGradient(gradient: Gradient(colors: [.clear, Color("Color-Marino")]), startPoint: .top, endPoint: .bottom))
                                    .cornerRadius(15)
                                
                                VStack{
                                    Text("\(miPeli.title)")
                                        .font(.title)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 1.5, x: 2, y: 2)
                                        .frame( height: 300, alignment: .bottom)
                                        .padding(.horizontal,20)
                                    MyProgressBar(progress: .constant(miPeli.vote_average))
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                                }
                            }
                            
                            /**
                            Button {
                                //
                            } label: {
                                Image(systemName: "play.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80, alignment: .center)
                                    .foregroundColor(.white)
                            } **/
                        }
                        Text("Top")
                            .font(.title3)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .frame( maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        LazyVGrid(columns: formaGrid, spacing: 8) {
                            ForEach(todasLasPelis.pelisInfo, id: \.self) {
                                peli in
                                Button {
                                    adult = peli.adult
                                    backdrop_path = peli.backdrop_path ?? "/5UX6M0aEphiW6Xmy5rpYX75glbo.jpg"
                                    genre_ids = peli.genre_ids
                                    id = peli.id
                                    original_language = peli.original_language
                                    original_title = peli.original_title
                                    overview = peli.overview
                                    popularity = peli.popularity
                                    poster_path = peli.poster_path
                                    release_date = peli.release_date ?? "-"
                                    title = peli.title
                                    video = peli.video
                                    vote_average = peli.vote_average
                                    vote_count = peli.vote_count
                                    
                                    peliculaDetalleIsActive = true
                                    print("Pulsaste \(title) isActive:\(peliculaDetalleIsActive)")
                                    
                                    
                                } label: {
                                    VStack{
                                        KFImage(URL(string: "https://image.tmdb.org/t/p/w440_and_h660_face\(peli.poster_path)")!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        
                                        Text("\(peli.title)")
                                            .frame(minHeight: 30, alignment: .center)
                                            .foregroundColor(.white)
                                            .font(.footnote)
                                            .lineLimit(2)
                                    }.padding(.bottom)
                                        
                                    }
                                }
                            
                            }
                        
                        } // scroll view
                    } // vstack
                
                NavigationLink(destination: PeliculaDetalleView(adult: adult, backdrop_path: backdrop_path, genre_ids: genre_ids, id: id, original_language: original_language, original_title: original_title, overview: overview, popularity: popularity, poster_path: poster_path, release_date: release_date, title: title, video: video, vote_average: vote_average, vote_count: vote_count), isActive: $peliculaDetalleIsActive, label:{EmptyView()})
                
                }
            .navigationBarHidden(true)
                                
            }//navitaionview
        }
    
    }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
    
