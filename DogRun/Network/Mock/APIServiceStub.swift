//
//  APIServiceStub.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/23.
//

import Foundation
import OSLog
// 스텁을 사용하여 테스트하기 위한 APIService 클래스
final class APIServiceStub: APIService {
    var networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol = NetworkManagerStub()) {
        self.networkManager = networkManager
    }
    override func retrieveData(data: String) async throws -> MainInfo? {
        var result: MainInfo?
        networkManager.fetchData(from: URL(string: APIEndpoint.retrieveMainData.urlString)!) { data, _, _ in
            var mockData: Data?
            do {
                mockData = data
                // 데이터 처리
                let response = try JSONDecoder().decode(ResponseMainData.self, from: mockData!)
                guard Utils.isSuccessResponse(code: response.code) else { return nil }
                result = response.data
            } catch {
                mockData = nil
            }
            return mockData
        }
        return result
    }
}
