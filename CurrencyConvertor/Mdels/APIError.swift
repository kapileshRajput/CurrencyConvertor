//
//  APIError.swift
//  CurrencyConvertor
//
//  Created by Kapilesh Rajput on 26/05/25.
//
import Foundation

enum APIError: Error {
    case invalidURL
    case decodingFailed(Error)
    case networkError(Error)
}
