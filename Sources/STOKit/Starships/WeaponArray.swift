public struct WeaponArray {
    public typealias Weapons = [Weapon?]

    private var weapons: Weapons

    public init(size: Int) {
        @Clamped(0...5) var _size = size
        self.weapons = Array(repeating: nil, count: _size)
    }

    public subscript(index: Int) -> Weapon? {
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

extension WeaponArray: CustomStringConvertible {
    public var description: String {
        return weapons
            .map { weapon in
                if let weapon = weapon { return "\(weapon)" }
                return "Empty"
            }
            .joined(separator: ", ")
    }
}

extension WeaponArray: Codable {
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
                    case is BeamWeapon: try container.encode(weapon as! BeamWeapon, forKey: key)
                    case is CannonWeapon: try container.encode(weapon as! CannonWeapon, forKey: key)
                    case is KineticTorpedoWeapon: try container.encode(weapon as! KineticTorpedoWeapon, forKey: key)
                    default: try container.encodeNil(forKey: key)
                }
            } else {
                try container.encodeNil(forKey: key)
            }
        }
    }
}
