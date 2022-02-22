//
//  NetworkingRequestManager.swift
//  TMDBapp
//
//  Created by 1 on 13.01.2022.
//

import Alamofire

struct NetworkingRequestsManager {
    var defaultPath = Constants.network.defaultPath
    var apiKey = Constants.network.apiKey
    
    func request<T>(endpoint: APIEndpoints,
                    method: HTTPMethod,
                    parameters: Parameters? = nil,
                    encoding: ParameterEncoding = URLEncoding.default,
                    responseType: T.Type,
                    headers: [String: String]? = nil,
                    onSuccess: @escaping ((_ response: T) -> Void),
                    onFailure: @escaping ((_ error: Error) -> Void)) where T : Decodable {
        self.request(endpoint: endpoint.rawValue, method: method, parameters: parameters, encoding: encoding, responseType: responseType, headers: headers, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func request<T>(endpoint: String,
                    method: HTTPMethod,
                    parameters: Parameters? = nil,
                    encoding: ParameterEncoding = URLEncoding.default,
                    responseType: T.Type,
                    headers: [String: String]? = nil,
                    onSuccess: @escaping ((_ response: T) -> Void),
                    onFailure: @escaping ((_ error: Error) -> Void))  where T : Decodable {
        //TODO: Add environment picker logic here
        let url = defaultPath + endpoint + apiKey
        
        var updatedHeaders: HTTPHeaders
        if let headers = headers {
            updatedHeaders = HTTPHeaders(headers)
        } else {
            updatedHeaders = HTTPHeaders()
        }
        
        let request = AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: updatedHeaders)
        request.responseJSON { response in

            switch response.result {
            case .success:
                do {
                    print(String(describing: response.response?.statusCode))
                    if let data = response.data {
                        print(String(data: data, encoding: .utf8))
                        let parsed = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
                        if parsed.success {
                            onSuccess(parsed.data)
                        } else {
                            onFailure(BNError.errorWithMessage(code: parsed.errorCode ?? -1, message: parsed.errorMessage ?? ""))
                        }
                    } else {
                        onFailure(BNError.parsingError)
                    }
                } catch {
                    print(error)
                }
            case let .failure(error):
                onFailure(error)
            }
        }
    }
}
