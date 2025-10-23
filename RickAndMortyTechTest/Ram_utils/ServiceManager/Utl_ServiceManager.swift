//
//  Utl_ServiceManager.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import Foundation

import Alamofire

/// `Utl_ServiceManager` facilita la comunicación con servicios web usando `async/await`.
public final class Utl_ServiceManager {
    
    /// Instancia compartida del `Utl_ServiceManager`.
    public static let shared = Utl_ServiceManager()
    
    /// Constructor privado para usar solo la instancia compartida.
    private init() {}
    
    /// Método genérico para realizar una solicitud HTTP y decodificar la respuesta en un modelo `Decodable`.
    ///
    /// - Parameters:
    ///   - baseUrl: URL base del servicio.
    ///   - queryParam: Ruta o parámetros del endpoint.
    ///   - method: Método HTTP (`.get`, `.post`, etc.).
    /// - Returns: Un objeto `Decodable` del tipo `T`.
    /// - Throws: Un error en caso de fallo de red o decodificación.
    @discardableResult
    public func callService<T: Decodable>(
        baseUrl: String = "https://rickandmortyapi.com/api/",
        queryParam: String,
        method: HTTPMethod = .get
    ) async throws -> T {
        let urlString: String = "\(baseUrl)\(queryParam)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let dataTask = AF.request(url, method: method)
            .validate()
            .serializingData()
        
        let response = await dataTask.response
        
        if let error = response.error {
            throw error
        }
        
        guard let data = response.data else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
