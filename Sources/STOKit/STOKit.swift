import Foundation

// test new features here before moving them to files

// public enum STOStat: Codable {
//     case Percent(op: STOStatOp, value: Double)

//     public init(from decoder: Decoder) {

//     }

//     public func encode(to encoder: Encoder) {

//     }
// }

// public enum STOStatOp: String, Codable {
//     case Plus, Minus
// }

// public protocol ShipComponent {
//     var name: String { get }
// }

// public struct ShipDeflector: ShipComponent {
//     public let name: String

//     public init() {
//         self.name = "Deflector"
//     }
// }

// @resultBuilder public struct WeaponArrayBuilder {
//     public static func buildBlock<W: STOWeapon>(_ components: W...) -> [W] {
//         return components
//     }
// }

public class AncientAntiprotonOmniBeamArray: STOOmniBeamArray {
    public init(_ mark: STOMark, _ quality: STOQuality) {
        super.init(.Antiproton, mark, quality)
    }

    public override var description: String {
        return "Ancient \(super.description)"
    }
}

public class STOPhotonTorpedo: STOTorpedo {
    public init( _ mark: STOMark, _ quality: STOQuality) {
        super.init(.Kinetic, mark, quality)
    }

    public override var description: String {
        return "Photon Torpedo - Mk \(mark) \(quality)"
    }
}

public class LightCruiser: STOStarship {
    public init(_ name: String) {
        super.init(name: name, foreWeapons: 2, rearWeapons: 1)
    }
}

public class AssaultCruiser: STOStarship {
    public init(_ name: String) {
        super.init(name: name, foreWeapons: 4, rearWeapons: 4)
    }
}
