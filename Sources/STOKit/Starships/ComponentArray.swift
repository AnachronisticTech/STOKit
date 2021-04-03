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
            if let component = component {
                switch component {
                    case is EngineeringConsole:
                        try container.encode(component as! EngineeringConsole, forKey: key)
                    case is ScienceConsole:
                        try container.encode(component as! ScienceConsole, forKey: key)
                    case is TacticalConsole:
                        try container.encode(component as! TacticalConsole, forKey: key)
                    case is BeamWeapon:
                        try container.encode(component as! BeamWeapon, forKey: key)
                    case is CannonWeapon:
                        try container.encode(component as! CannonWeapon, forKey: key)
                    case is KineticTorpedoWeapon:
                        try container.encode(component as! KineticTorpedoWeapon, forKey: key)
                    default:
                        try container.encodeNil(forKey: key)
                }
            } else {
                try container.encodeNil(forKey: key)
            }
        }
    }
}
