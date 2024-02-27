//
//  NetworkManagerProtocol.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/23.
//

import Foundation

// 네트워크 매니저 프로토콜 정의
protocol NetworkManagerProtocol {
    func fetchData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Data?)
}
