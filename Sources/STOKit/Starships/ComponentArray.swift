public struct ComponentArray<Component: Item> {
    public typealias Components = [Component?]

    private var components: Components

    public init(size: Int) {
        @Clamped(0...5) var _size = size
        self.components = Array(repeating: nil, count: _size)
    }

    public subscript(index: Int) -> Component? {
        get {
            guard (0..<components.count).contains(index) else { return nil }
            return components[index]
        }
        set {
            guard (0..<components.count).contains(index) else { return }
            components[index] = newValue
        }
    }

    public var count: Int { components.count }
}

extension ComponentArray: CustomStringConvertible {
    public var description: String {
        return components
            .map { component in
                if let component = component { return "\(component)" }
                return "Empty"
            }
            .joined(separator: ", ")
    }
}

internal enum ComponentArrayCodingKeys: String, CodingKey, CaseIterable {
    case slot1, slot2, slot3, slot4, slot5
}

extension ComponentArray: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ComponentArrayCodingKeys.self)
        for (index, component) in components.enumerated() {
            let key = ComponentArrayCodingKeys.allCases.filter({ $0.rawValue.contains("\(index+1)") }).first!
            guard let component = component else {
                try container.encodeNil(forKey: key)
                continue
            }
            try container.encode(component, forKey: key)
        }
    }
}
