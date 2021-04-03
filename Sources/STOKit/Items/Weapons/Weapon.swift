internal protocol WeaponBase: Item, CustomStringConvertible, Codable {}

open class Weapon: WeaponBase {
    public let mark: Mark
    public let quality: Quality

    public var description: String { "Weapon Base" }

    internal init(_ mark: Mark, _ quality: Quality) {
        self.mark = mark
        self.quality = quality
    }

    public required init(from decoder: Decoder) throws {
        fatalError("You cannot instantiate an abstract weapon")
    }

    public func encode(to encoder: Encoder) throws {
        fatalError("You cannot encode an abstract weapon")
    }
}

enum WeaponCodingKeys: String, CodingKey {
    case mark, quality, `class`
    case _weaponType = "weaponType"
    case _damageType = "damageType"
}

public protocol WeaponType {}

public enum BeamWeaponType: String, WeaponType, Codable, CustomStringConvertible {
    case BeamArray, DualBeamBank, OmnidirectionalBeamArray

    public var description: String {
        switch self {
            case .BeamArray: return "Beam Array"
            case .DualBeamBank: return "Dual Beam Bank"
            case .OmnidirectionalBeamArray: return "Omnidirectional Beam Array"
        }
    }
}

public enum CannonWeaponType: String, WeaponType, Codable, CustomStringConvertible {
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

public enum TorpedoWeaponType: String, WeaponType, Codable, CustomStringConvertible {
    case Standard, WideAngle

    public var description: String {
        switch self {
            case .Standard: return ""
            case .WideAngle: return "Wide-Angle "
        }
    }
}
