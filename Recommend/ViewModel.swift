//
//  ViewModel.swift
//  Recommend
//
//  Created by Ignacio Bogarin on 30/04/22.
//

import Foundation


class ViewModel: ObservableObject {
    @Published var pelisInfo = [Pelicula]()
    
    @Published var actoresInfo = [Actor]()
    @Published var videosInfo = [Video]()
    @Published var similarInfo = [Pelicula]()
    
    @Published var actoresPeliculasInfo = [ActorPelicula]()
    @Published var actorDetalleInfo = ActorDetalle.self
    
    
    
    init(){
        obtenerPelis()
    }
    
    func obtenerPelis(){
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=9d9c3604ec0dac82d9e8da333d079e75&language=es-MX&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                if let jsonData = data {
                    print("JsonData :: \(jsonData)")
                    let decodeData = try JSONDecoder().decode(Peliculas.self, from: jsonData)
                    DispatchQueue.main.async {
                        self.pelisInfo.append(contentsOf: decodeData.results)
                    }
                    //print("Data \(decodeData)")
                    //print("::Data decode:: \(self.pelisInfo)")
                }
            } catch {
                print("Error:: \(error) Los Datos son: -> \(data)")
            }
        }.resume()
    }
    
    func obtenerActores(myId:Int){
        let x3  = "https://api.themoviedb.org/3/movie/"
        let x4  = "/credits?api_key=9d9c3604ec0dac82d9e8da333d079e75&language=es-MX";
        let xid = myId
        
        let myUrl = "\(x3)\(xid)\(x4)"
        
        let url = URL(string: myUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                if let jsonData = data {
                    print("JsonData :: \(jsonData)")
                    let decodeData = try JSONDecoder().decode(Actores.self, from: jsonData)
                    DispatchQueue.main.async {
                        self.actoresInfo.append(contentsOf: decodeData.cast)
                    }
                    //print("Data \(decodeData)")
                    //print("::Actores decode:: \(self.actoresInfo)")
                }
            } catch {
                print("MyError:: \(error) Los Datos son: - \(data)")
            }
        }.resume()
    }
    
    func obtenerVideos(myId:Int){
        let x3  = "https://api.themoviedb.org/3/movie/"
        let x4  = "/videos?api_key=9d9c3604ec0dac82d9e8da333d079e75&language=es-US";
        let xid = myId
    
        let myUrl = "\(x3)\(xid)\(x4)"
        
        let url = URL(string: myUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                if let jsonData = data {
                    print("JsonData :: \(jsonData)")
                    let decodeData = try JSONDecoder().decode(Videos.self, from: jsonData)
                    DispatchQueue.main.async {
                        self.videosInfo.append(contentsOf: decodeData.results)
                    }
                    //print("Data \(decodeData)")
                    //print("::Videos decode:: \(self.videosInfo)")
                }
            } catch {
                print("MyError:: \(error) Los Videos son: - \(data)")
            }
        }.resume()
    }
    
    func obtenerSimilares(myId:Int){
        let x3  = "https://api.themoviedb.org/3/movie/"
        let x4  = "/similar?api_key=9d9c3604ec0dac82d9e8da333d079e75&language=es-MX&page=1";
        let xid = myId
    
        let myUrl = "\(x3)\(xid)\(x4)"
        
        let url = URL(string: myUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                if let jsonData = data {
                    print("JsonData :: \(jsonData)")
                    let decodeData = try JSONDecoder().decode(Peliculas.self, from: jsonData)
                    DispatchQueue.main.async {
                        self.similarInfo.append(contentsOf: decodeData.results)
                    }
                    print("Data \(decodeData)")
                    print("::Similar decode:: \(self.similarInfo)")
                }
            } catch {
                print("MyError:: \(error) Los Videos son: - \(data)")
            }
        }.resume()
    }
    
    func obtenerActorPeliculas(myId:Int){
        let x3  = "https://api.themoviedb.org/3/person/"
        let x4  = "/movie_credits?api_key=9d9c3604ec0dac82d9e8da333d079e75&language=es-MX";
        let xid = myId
    
        let myUrl = "\(x3)\(xid)\(x4)"
        
        let url = URL(string: myUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                if let jsonData = data {
                    print("JsonData :: \(jsonData)")
                    let decodeData = try (JSONDecoder().decode(ActorTodasPeliculas.self, from: jsonData))

                    DispatchQueue.main.async {
                        self.actoresPeliculasInfo.append(contentsOf: decodeData.cast.sorted(by: {$0.popularity ?? 0 > $1.popularity ?? 0}))
                    }
                    print("Data \(decodeData)")
                    print("::Actor Pelis decode:: \(self.actoresPeliculasInfo)")
                }
            } catch {
                print("MyError:: \(error) Los Videos son: - \(data)")
            }
        }.resume()
    }
    
    
}
