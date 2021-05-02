internal protocol WeaponBase {}

open class Weapon: Item, WeaponBase {}

enum WeaponCodingKeys: String, CodingKey {
    case mark, quality, `class`
    case _weaponType = "weaponType"
    case _damageType = "damageType"
}

public protocol WeaponType: Codable, CustomStringConvertible {}

public enum BeamWeaponType: String, WeaponType {
    case BeamArray, DualBeamBank, OmnidirectionalBeamArray

    public var description: String {
        switch self {
            case .BeamArray: return "Beam Array"
            case .DualBeamBank: return "Dual Beam Bank"
            case .OmnidirectionalBeamArray: return "Omnidirectional Beam Array"
        }
    }
}

public enum CannonWeaponType: String, WeaponType {
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

public enum TorpedoWeaponType: String, WeaponType {
    case Standard, WideAngle

    public var description: String {
        switch self {
            case .Standard: return ""
            case .WideAngle: return "Wide-Angle "
        }
    }
}
