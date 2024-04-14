//
//  Binding.swift
//  Subtasks
//

import Adwaita

extension Binding: CustomStringConvertible where Value: CustomStringConvertible {

    /// A localized description of the wrapped value.
    public var description: String {
        wrappedValue.description
    }

}
