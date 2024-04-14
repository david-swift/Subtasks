//
//  Task.swift
//  Subtasks
//

import Foundation

struct Task: Codable, Identifiable, CustomStringConvertible {

    var id: UUID = .init()
    var label: String
    var done = false
    var subtasks: [Self] = []

    var description: String {
        label
    }

    var mixed: Bool {
        !done && subtasks.contains { subtask in
            subtask.mixed || subtask.done
        }
    }

    mutating func delete(id: UUID) {
        subtasks.delete(id: id)
    }

}
