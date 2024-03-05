//
//  NetworkManagerStub.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/23.
//
import Foundation

// 네트워크 매니저 스텁 클래스
final class NetworkManagerStub: NetworkManagerProtocol {
    var testData: Data?
    var testError: Error?
    func setTestData(from jsonFileName: String) {
        guard let url = Bundle.main.url(forResource: jsonFileName, withExtension: "json") else { return }
        do {
            self.testData = try Data(contentsOf: url)
        } catch {
        }
    }
    func fetchData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Data?) {
        // 미리 정의된 테스트 데이터와 오류를 반환
        completion(testData, nil, testError)
    }
}
