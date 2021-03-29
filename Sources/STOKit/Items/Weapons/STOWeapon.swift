public protocol STOWeapon: STOItem, CustomStringConvertible, Codable {}

enum STOWeaponCodingKeys: String, CodingKey {
    case mark, quality, `class`
    case _weaponType = "weaponType"
    case _damageType = "damageType"
}

public protocol STOWeaponType {}

public enum STOBeamWeaponType: String, STOWeaponType, Codable, CustomStringConvertible {
    case BeamArray, DualBeamBank, OmnidirectionalBeamArray

    public var description: String {
        switch self {
            case .BeamArray: return "Beam Array"
            case .DualBeamBank: return "Dual Beam Bank"
            case .OmnidirectionalBeamArray: return "Omnidirectional Beam Array"
        }
    }
}

public enum STOCannonWeaponType: String, STOWeaponType, Codable, CustomStringConvertible {
    case Single, Dual, DualHeavy, Quad

    public var description: String {
        switch self {
            case .Single: return "Single Cannon"
            case .Dual: return "Dual Cannons"
            case .DualHeavy: return "Dual Heavy Cannons"
            case .Quad: return "Quad Cannons"
        }
    }
}

public enum STOTorpedoWeaponType: String, STOWeaponType, Codable, CustomStringConvertible {
    case Standard, WideAngle

    public var description: String {
        switch self {
            case .Standard: return ""
            case .WideAngle: return "Wide-Angle "
        }
    }
}
