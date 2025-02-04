//
//  URLRequest.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 04.02.2025.
//

import Foundation

public extension URLRequest {
    public var curl: String? {
        guard let url else { return nil }

        var baseCommand = #"curl "\#(url.absoluteString)""#
        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }

        var commandComponents = [baseCommand]

        if let method = httpMethod, method != "GET" && method != "HEAD" {
            commandComponents.append("-X \(method)")
        }
        for (key, value) in (allHTTPHeaderFields ?? [:]) where key != "Cookie" {
            commandComponents.append("-H '\(key): \(value)'")
        }

        if let data = httpBody {
            commandComponents.append("-d '\(String(decoding: data, as: UTF8.self))'")
        }

        return commandComponents.joined(separator: " ")
    }
}

