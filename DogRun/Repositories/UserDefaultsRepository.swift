//
//  UserDefaultsRepository.swift
//  DogRun
//
//  Created by 이규관 on 2024/03/07.
//

import Foundation

protocol UserDefaultsRepository {
    
    // 데이터 저장
    func save(key: String, data: Any)
    func retrieval(key: String) throws -> Any?
}
