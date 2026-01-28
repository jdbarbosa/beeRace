// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol APIClient: Sendable {

    var baseUrl: String { get }

    var decoder: JSONDecoder { get }

    /// Starts a URLSessionDataTask using the request for the corresponding APIResource.
    ///
    /// - Parameters:
    ///   - resource: APIResource defining some remote resource.
    /// - Returns: Decoded response for the corresponding resource.
    func sendURLSessionRequest<T: APIRequest>(for resource: T) async throws -> T.Response
}

extension APIClient {

    public func sendURLSessionRequest<T: APIRequest>(for resource: T) async throws -> T.Response {

        guard let request = resource.buildRequest(withBaseUrl: URL(string: self.baseUrl)) else {
            print("Bad url")
            throw APIError.client
        }
        print("URL: \(request.url?.absoluteString ?? "")")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299:
                    break // OK
                case 403:
                    let captcha = try? decoder.decode(CaptchaResponse.self, from: data)
                    let url = captcha.flatMap { URL(string: $0.captchaUrl) }
                    print("url: \(url?.absoluteString ?? "")")
                    throw APIError.forbidden(captchaURL: url)
                case 429:
                    throw APIError.client
                default:
                    throw APIError.network
                }
            }
            return try decoder.decode(T.Response.self, from: data)
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.network
        }
    }
}

public final class BeeRaceAPIClient: APIClient, @unchecked Sendable {
    public var baseUrl = "https://rtest.proxy.beeceptor.com/bees/race"

    public var decoder = JSONDecoder()

    public init() {}

}
