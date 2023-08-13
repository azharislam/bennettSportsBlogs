//
//  Array + Chunked.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 13/08/2023.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
