//
//  Array.swift
//  Subtasks
//

import Foundation

extension Array where Element == Task {

    mutating func delete(id: UUID) {
        self = filter { $0.id != id }
        for index in indices {
            self[safe: index]?.delete(id: id)
        }
    }

}
