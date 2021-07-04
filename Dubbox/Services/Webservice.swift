//
//  Webservice.swift
//  Dubbox
//
//  Created by Manoel Filho on 03/07/21.
//

import Foundation

enum AuthenticationError: Error{
    case invalidCredentials
    case emailAlreadyRegistered
    case custom(errorMessage: String)
}

class Webservice{
    
    func register(user: User, completion: @escaping (Result<Response, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "\(K.api_url)/api/v1/register") else {
            completion(.failure(.custom(errorMessage: "URL inválida")))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(user)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "Nenhum dado retornado")))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 422{
                    completion(.failure(.emailAlreadyRegistered))
                    return
                }
            }
            
            guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                completion(.failure(.custom(errorMessage: "Erro no cadastro do usuário")))
                return
            }

            completion(.success(response))
            
        }.resume()
        
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Response, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "\(K.api_url)/api/v1/login") else {
            completion(.failure(.custom(errorMessage: "URL inválida")))
            return
        }
        
        let login = Login(email: email, password: password)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(login)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "Nenhum dado retornado")))
                return
            }
            
            guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }

            completion(.success(response))
            
        }.resume()
        
        
    }
    
}
