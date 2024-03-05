//
//  LabelKeys.swift
//  DogRun
//
//  Created by 이규관 on 2024/02/23.
//
import Foundation

enum LabelKeys {
    enum User: String {
        case name = "label_nickname"
        case birth = "label_birth"
        case gender = "label_gender"
        case area = "label_area"
    }

    enum Dog: String {
        case name = "label_dog_name"
        case breed = "label_dog_breed"
        case age = "label_dog_age"
        case gender = "label_dog_gender"
        case size = "label_dog_size"
    }
}
