internal protocol WeaponBase {}

open class Weapon: Item, WeaponBase {
    internal override class func decode(container: KeyedDecodingContainer<Keys>) -> Self? {
        guard let className = try? container.decode(String.self, forKey: .class) else { return nil }

        if 
            BeamWeapon.specialTypes[className] != nil,
            let weapon = BeamWeapon.decode(container: container) as? Self
        {
            return weapon
        } else if 
            CannonWeapon.specialTypes[className] != nil,
            let weapon = CannonWeapon.decode(container: container) as? Self
        {
            return weapon
        } else if 
            KineticTorpedoWeapon.specialTypes[className] != nil,
            let weapon = KineticTorpedoWeapon.decode(container: container) as? Self
        {
            return weapon
        } else if 
            EnergyTorpedoWeapon.specialTypes[className] != nil,
            let weapon = EnergyTorpedoWeapon.decode(container: container) as? Self
        {
            return weapon
        }

        return nil
    }
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
