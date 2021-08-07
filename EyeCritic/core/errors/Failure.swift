//
//  Failure.swift
//  EyeCritic
//
//  Created by Pedro Rodrigues on 06/08/21.
//

import Foundation

enum FailureType: String, CaseIterable {
    case server = "ServerFailure"
    case cache = "CacheFailure"
}

struct Failure: Error {
    var type: FailureType
}
