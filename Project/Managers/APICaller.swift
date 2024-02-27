//
//  APICaller.swift
//  Project
//
//  Created by Kaan Uzun on 23.01.2024.
//

import Foundation

//Getting the API's from spotify.developers API documents.

final class APICaller {
  static let shared = APICaller()

  private init() {

  }

  struct Constants {
    static let baseAPIURL = "https://api.spotify.com/v1"
  }

  enum APIError: Error {
    case failedToGetData
    case failedToGetNewReleasesData
  }

  //MARK: -- ALBUMS
  
  public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailsResponse, Error>) -> Void){
    createRequest(
      with: URL(string: Constants.baseAPIURL + "/albums/" + album.id),
      type: .GET
    ) { request in
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        do {
          let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
          completion(.success(result))
        }
        catch {
          completion(.failure(error))
        }
      }
      task.resume()
    }

  }


  //MARK: -- PLAYLISTS

  public func getPlaylistDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse, Error>) -> Void){
    createRequest(
      with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id),
      type: .GET
    ) { request in
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        do {
          let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
          print(result)
          completion(.success(result))
        }
        catch {
          completion(.failure(error))
        }
      }
      task.resume()
    }

  }

  //MARK: -- PROFILE

  public func getCurrentUserProfile(completion: @escaping (Result<UserProfile,Error>) -> Void){
          createRequest(
            with: URL(string: Constants.baseAPIURL + "/me"),
            type: .GET
          ) { baseRequest in
              let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                  guard let data = data, error == nil else {
                      completion(.failure(APIError.failedToGetData))
                      return
                  }
                  do {
                    let result =  try JSONDecoder().decode(UserProfile.self, from: data)
//                    let result =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
                    completion(.success(result))
                  }
                  catch {
                    print(error.localizedDescription)
                      completion(.failure(error))
                  }
              }
              task.resume()
          }
      }

  //MARK: -- BROWSE

  public func getNewReleases (completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
    createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
      let task = URLSession.shared.dataTask(with: request) {data, _, error in
        guard let data = data, error == nil else{
          completion(.failure(APIError.failedToGetNewReleasesData))
          return
        }
        do{
          let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
          completion(.success(result))
        } catch {
            completion(.failure(error))
        }
      }
      task.resume()
    }
  }

  public func getFeaturedPlaylists (completion: @escaping ((Result<FeaturedPlaylistResponse, Error>)) -> Void) {
    createRequest(
      with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=20"),
      type: .GET
    ) { request in

      let task = URLSession.shared.dataTask(with: request) {data, _, error in
        guard let data = data, error == nil else{
          completion(.failure(APIError.failedToGetNewReleasesData))
          return
        }
        do{
          let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
          completion(.success(result))
        } catch {
            completion(.failure(error))
        }
      }
      task.resume()

    }

  }

  public func getRecommendedGenres (completion: @escaping ((Result<RecommendedGenres, Error>)) -> Void) {
    createRequest(
      with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"),
      type: .GET
    ) { request in

      let task = URLSession.shared.dataTask(with: request) {data, _, error in
        guard let data = data, error == nil else{
          completion(.failure(APIError.failedToGetNewReleasesData))
          return
        }
        do{
          let result =  try JSONDecoder().decode(RecommendedGenres.self, from: data)
          completion(.success(result))
        } catch {
            completion(.failure(error))
        }
      }
      task.resume()

    }

  }
  public func getRecommendations (genres: Set<String>, completion: @escaping ((Result<RecommendationsResponse, Error>)) -> Void) {
    let seeds = genres.joined(separator: ",")
    createRequest(
      with: URL(string: Constants.baseAPIURL + "/recommendations?limit=40&seed_genres=\(seeds)"),
      type: .GET
    ) { request in
      let task = URLSession.shared.dataTask(with: request) {data, _, error in
        guard let data = data, error == nil else{
          completion(.failure(APIError.failedToGetNewReleasesData))
            return
        }
        do{
          let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
   //       print("done")
          completion(.success(result))
        } catch {
   //       print("problem?")
            completion(.failure(error))
        }
      }
      task.resume()

    }

  }

  // MARK: - Private

  enum HTTPMethod: String {
    case GET
    case POST
  }

  private func createRequest(
    with url: URL?,
    type: HTTPMethod,
    completion: @escaping (URLRequest) -> Void
  ) {
      AuthManager.shared.withValidToken { token in
        guard let apiURL = url else {
          return
        }
        var request = URLRequest(url: apiURL)
        request.setValue("Bearer \(token)",
                         forHTTPHeaderField: "Authorization")
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
      }
  }

}
