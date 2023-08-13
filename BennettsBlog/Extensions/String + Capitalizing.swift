//
//  String + Capitalizing.swift
//  BennettsBlog
//
//  Created by Azhar Islam on 13/08/2023.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
