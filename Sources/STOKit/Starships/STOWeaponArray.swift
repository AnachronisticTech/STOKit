public struct STOWeaponArray {
    public typealias Weapons = [STOWeapon?]

    private var weapons: Weapons

    public init(size: Int) {
        @Clamped(0...5) var _size = size
        self.weapons = Array(repeating: nil, count: _size)
    }

    public subscript(index: Int) -> STOWeapon? {
        get {
            guard (0..<weapons.count).contains(index) else { return nil }
            return weapons[index]
        }
        set {
            guard (0..<weapons.count).contains(index) else { return }
            weapons[index] = newValue
        }
    }
}

extension STOWeaponArray: CustomStringConvertible {
    public var description: String {
        return weapons
            .map { weapon in
                if let weapon = weapon { return "\(weapon)" }
                return "Empty"
            }
            .joined(separator: ", ")
    }
}

extension STOWeaponArray: Codable {
    enum CodingKeys: String, CodingKey, CaseIterable {
        case slot1, slot2, slot3, slot4, slot5
    }

    public init(from decoder: Decoder) throws {
        fatalError("Not yet implemented")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        for (index, weapon) in weapons.enumerated() {
            let key = CodingKeys.allCases.filter({ $0.rawValue.contains("\(index+1)") }).first!
            if let weapon = weapon {
                switch weapon {
                    case is STOBeamWeapon: try container.encode(weapon as! STOBeamWeapon, forKey: key)
                    case is STOCannonWeapon: try container.encode(weapon as! STOCannonWeapon, forKey: key)
                    case is STOKineticTorpedoWeapon: try container.encode(weapon as! STOKineticTorpedoWeapon, forKey: key)
                    default: try container.encodeNil(forKey: key)
                }
            } else {
                try container.encodeNil(forKey: key)
            }
        }
    }
}
