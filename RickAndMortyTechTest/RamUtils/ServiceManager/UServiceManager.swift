//
//  UServiceManager.swift
//  RickAndMortyTechTest
//
//  Created by Juan Diego Garcia Serrano on 23/10/25.
//

import Foundation

import Alamofire

/// `UServiceManager` facilita la comunicación con servicios web usando `async/await`.
public final class UServiceManager {
    
    /// Instancia compartida del `UServiceManager`.
    public static let shared = UServiceManager()
    
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
        var urlString: String = "\(baseUrl)\(queryParam)"
        
        urlString = urlString
            .replacingOccurrences(of: "%5B", with: "[")
            .replacingOccurrences(of: "%5D", with: "]")
        
        let dataTask = AF.request(urlString, method: method)
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
