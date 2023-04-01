//
//  Model.swift
//  Recommend
//
//  Created by Ignacio Bogarin on 30/04/22.
//

import Foundation

struct Peliculas:Codable, Hashable {
    var page: Int
    var results : [Pelicula]
}

struct Pelicula:Codable, Hashable {
    var adult: Bool
    var backdrop_path: String?
    var genre_ids: [Int]
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Float
    var poster_path: String
    var release_date: String?
    var title: String
    var video: Bool
    var vote_average: Float
    var vote_count: Int
}

struct Series:Codable {
    var series: [Serie]
}

struct Serie:Codable {
    var backdrop_path: String
    var first_air_date:String
    var genre_ids: [Int]
    var id: Int
    var name: String
    var origin_country: [String]
    var original_lenguage: String
    var original_name: String
    var popularity: Float
    var poster_path: String
    var vote_average: Float
    var vote_count: Int
}

struct Actores: Codable, Hashable{
    var id:Int
    var cast: [Actor]
}

struct Actor: Codable, Hashable {
    var adult: Bool
    var gender: Int
    var id: Int
    var known_for_department: String
    var name: String
    var original_name: String
    var popularity: Float
    var profile_path: String?
    var cast_id: Int
    var character: String
    var credit_id: String
    var order: Int
}

struct ActorDetalle: Codable, Hashable {
    var biography: String
    var birthday: String
    var deathday: String?
    var id: Int
    var name: String
    var place_of_birth: String
    var profile_path: String
}

struct ActorTodasPeliculas: Codable, Hashable {
    var id: Int
    var cast: [ActorPelicula]
}

struct ActorPelicula: Codable, Hashable {
    var adult: Bool
    var backdrop_path: String?
    var genre_ids: [Int]
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var poster_path: String?
    var release_date: String?
    var title: String
    var video: Bool
    var vote_average: Float
    var vote_count: Int
    var popularity: Float?
    var character: String?
    var credit_id: String
    var order: Int
}

struct Videos: Codable, Hashable {
    var id: Int
    var results: [Video]
}

struct Video: Codable, Hashable {
    var name: String
    var key: String
    var site: String
    var type: String
    var id: String
}
