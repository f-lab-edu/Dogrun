//
//  MockURLProtocol.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/17.
//

import Foundation

class MockURLProtocol: URLProtocol {
     
    override class func canInit(with request: URLRequest) -> Bool {
        return true // 모든 요청을 가로채도록 설정
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let url = request.url else { return }
        // JSON 파일에서 데이터 읽어오기
        if url.absoluteString.contains(LocalizationKeys.baseUrl.rawValue.localized),
           let jsonFilePath = Bundle.main.path(forResource: "mockData", ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonFilePath)) {
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: jsonData)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
    }
}
