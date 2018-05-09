//
//  Result.swift
//  JFLib
//
//  Created by Josh Freed on 10/2/17.
//  Copyright © 2017 Josh Freed. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}

public enum EmptyResult {
    case success
    case failure(Error)
}
