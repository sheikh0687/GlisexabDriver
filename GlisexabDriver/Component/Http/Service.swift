//
//  Service.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 31/10/25.
//

import Foundation
import Alamofire
import UIKit

// MARK: - Error Enum
enum ApiError: Error, LocalizedError {
    case noInternet
    case serverError(String)
    case decodingError(String)
    case invalidResponse
    case unknown(String)
    
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No Internet connection. Please check your network."
        case .serverError(let msg):
            return msg
        case .decodingError(let msg):
            return "Data parsing failed: \(msg)"
        case .invalidResponse:
            return "Received an invalid response from server."
        case .unknown(let msg):
            return msg
        }
    }
}

// MARK: - Service Layer
final class Service {
    
    static let shared = Service()
    private init() {}
    
    private let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.urlCache = nil
        return Session(configuration: config)
    }()
    
    // MARK: - Connectivity Check
    private func checkConnection() -> Bool {
        return Utility.checkNetworkConnectivityWithDisplayAlert(isShowAlert: false)
    }
    
    // MARK: - Raw Data Request
    func requestData (
        url: String,
        method: HTTPMethod = .post,
        params: [String: Any]? = nil
    ) async throws -> Data {
        guard checkConnection() else { throw ApiError.noInternet }
        
        let request = session.request(url, method: method, parameters: params)
        let data = try await request.serializingData().value
        
        if let params = params, !params.isEmpty {
            let queryString = params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            let fullUrl = "\(url)?\(queryString)"
            print("""
            🟢 Full API for Browser
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            \(fullUrl)
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            """)
        } else {
            print("""
            🟢 Full API for Browser
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            \(url)
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            """)
        }

        return data
    }
    
    // MARK: - Decodable Request
    func request<T: Decodable> (
        url: String,
        method: HTTPMethod = .post,
        params: [String: Any]? = nil
    )  async throws -> T {
        let data = try await requestData(url: url, method: method, params: params)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // MARK: - Upload Single Media
    func uploadSingleMedia<T: Decodable> (
        url: String,
        params: [String: String]? = nil,
        images: [String: UIImage]? = nil,
        videos: [String: Data]? = nil
    ) async throws -> T {
        guard checkConnection() else { throw ApiError.noInternet }
        
        return try await withCheckedThrowingContinuation { continuation in
            session.upload(multipartFormData: { multipart in
                self.appendParameters(params, to: multipart)
                self.appendImages(images, to: multipart)
                self.appendVideos(videos, to: multipart)
            }, to: url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        continuation.resume(returning: decoded)
                    } catch {
                        print("❌ Decoding failed: \(error.localizedDescription)")
                        continuation.resume(throwing: ApiError.decodingError(error.localizedDescription))
                    }
                case .failure(let error):
                    print("❌ Upload Failed: \(error.localizedDescription)")
                    continuation.resume(throwing: ApiError.serverError(error.localizedDescription))
                }
            }
        }
    }

    // MARK: - Upload Multiple Media
    func uploadMultipleMedia (
        url: String,
        params: [String: String]? = nil,
        imageArrays: [String: [UIImage]]? = nil,
        videoURLs: [String: [URL]]? = nil
    ) async throws -> Data {
        guard checkConnection() else { throw ApiError.noInternet }
        
        return try await withCheckedThrowingContinuation { continuation in
            session.upload(multipartFormData: { multipart in
                self.appendParameters(params, to: multipart)
                
                // Multiple Images
                imageArrays?.forEach { key, images in
                    for image in images {
                        if let data = image.jpegData(compressionQuality: 0.7) {
                            multipart.append(data,
                                             withName: key,
                                             fileName: "\(UUID().uuidString).jpg",
                                             mimeType: "image/jpeg")
                        }
                    }
                }
                
                // Multiple Videos
                videoURLs?.forEach { key, urls in
                    for url in urls {
                        multipart.append(url,
                                         withName: key,
                                         fileName: "\(UUID().uuidString).mp4",
                                         mimeType: "video/mp4")
                    }
                }
            }, to: url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    print("✅ Upload Success")
                    continuation.resume(returning: data)
                case .failure(let error):
                    print("❌ Upload Failed: \(error.localizedDescription)")
                    continuation.resume(throwing: ApiError.serverError(error.localizedDescription))
                }
            }
        }
    }
    
    // MARK: - Upload With Files (PDF, etc.)
//    func uploadWithFiles(
//        url: String,
//        params: [String: String]? = nil,
//        pdfData: [String: Data]? = nil,
//        videos: [String: Data]? = nil,
//        completion: @escaping (Result<Data, ApiError>) -> Void
//    ) {
//        guard checkConnection() else {
//            completion(.failure(.noInternet))
//            return
//        }
//        
//        session.upload(multipartFormData: { multipart in
//            self.appendParameters(params, to: multipart)
//            
//            // PDFs
//            pdfData?.forEach { key, data in
//                multipart.append(data,
//                                 withName: key,
//                                 fileName: "\(key).pdf",
//                                 mimeType: "application/pdf")
//            }
//            
//            // Videos
//            self.appendVideos(videos, to: multipart)
//        }, to: url)
//        .validate()
//        .responseData { response in
//            self.handleUploadResponse(response, completion: completion)
//        }
//    }
}

// MARK: - Multipart Helpers
private extension Service {
    
    func appendParameters(_ params: [String: String]?, to multipart: MultipartFormData) {
        params?.forEach { key, value in
            if let data = value.data(using: .utf8) {
                multipart.append(data, withName: key)
            }
        }
    }
    
    func appendImages(_ images: [String: UIImage]?, to multipart: MultipartFormData) {
        images?.forEach { key, image in
            if let data = image.jpegData(compressionQuality: 0.7) {
                multipart.append(data,
                                 withName: key,
                                 fileName: "\(key).jpg",
                                 mimeType: "image/jpeg")
            }
        }
    }
    
    func appendVideos(_ videos: [String: Data]?, to multipart: MultipartFormData) {
        videos?.forEach { key, data in
            multipart.append(data,
                             withName: key,
                             fileName: "\(key).mp4",
                             mimeType: "video/mp4")
        }
    }
    
//    func handleUploadResponse(
//        _ response: AFDataResponse<Data>,
//        completion: @escaping (Result<Data, ApiError>) -> Void
//    ) {
//        switch response.result {
//        case .success(let data):
//            print("✅ Upload Success")
//            completion(.success(data))
//        case .failure(let error):
//            print("❌ Upload Failed: \(error.localizedDescription)")
//            completion(.failure(.serverError(error.localizedDescription)))
//        }
//    }
}
