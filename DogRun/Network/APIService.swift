//
//  ApiService.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/06.
//
import Foundation

class APIService {
    // 사용자 로그인
    func signIn(data: LoginInfo) async throws -> UserInfo? {
        do {
            let url = URL(string: APIEndpoint.signIn.urlString)!
            let request = try makeRequest(to: url, method: .POST, with: data)
            // HTTP 요청
            let data = try await URLSession.shared.data(for: request).0
            // 데아터 처리
            let responseData = try JSONDecoder().decode(ResponseLoginData.self, from: data)
            guard Utils.isSuccessResponse(code: responseData.code) else { return nil }
            return responseData.data
        } catch {
            throw error
        }
    }
    // 유저 정보 업데이트
    func updateUserInfo(data: UserInfo) async throws -> UserInfo? {
        do {
            let url = URL(string: APIEndpoint.updateUser.urlString)!
            let request = try makeRequest(to: url, method: .POST, with: data)
            // HTTP 요청
            let data = try await URLSession.shared.data(for: request).0
            // 데아터 처리
            let responseData = try JSONDecoder().decode(ResponseLoginData.self, from: data)
            guard Utils.isSuccessResponse(code: responseData.code) else { return nil }
            return responseData.data
        } catch {
            throw error
        }
    }
    // 펫 정보 업데이트
    func updateDogInfo(data: DogInfo) async throws -> DogInfo? {
        do {
            let url = URL(string: APIEndpoint.updateDog.urlString)!
            let request = try makeRequest(to: url, method: .POST, with: data)
            // HTTP 요청
            let data = try await URLSession.shared.data(for: request).0
            // 데아터 처리
            let responseData = try JSONDecoder().decode(ResponseDogInfoData.self, from: data)
            guard Utils.isSuccessResponse(code: responseData.code) else { return nil }
            return responseData.data
        } catch {
            throw error
        }
    }
    // 메인화면 정보 조회
    func retrieveData(data: String) async throws -> MainInfo? {
        do {
            let url = URL(string: APIEndpoint.retrieveMainData.urlString)!
            let request = try makeRequest(to: url, method: .POST, with: data)
            // HTTP 요청
            let data = try await URLSession.shared.data(for: request).0
            // 데아터 처리
            let responseData = try JSONDecoder().decode(ResponseMainData.self, from: data)
            guard Utils.isSuccessResponse(code: responseData.code) else { return nil }
            return responseData.data
        } catch {
            throw error
        }
    }
    func makeRequest<T: Encodable>(to url: URL, method: HTTPMethod, with data: T?)
    throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let data = data {
            request.httpBody = try JSONEncoder().encode(data)
        }
        return request
    }
}
