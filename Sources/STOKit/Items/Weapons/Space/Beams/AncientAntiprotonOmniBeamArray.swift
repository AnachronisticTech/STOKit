public class AncientAntiprotonOmniBeamArray: STOBeamWeapon {
    public init(_ mark: STOMark, _ quality: STOQuality) {
        super.init(.OmnidirectionalBeamArray, .Antiproton, mark, quality)
    }

    internal required init(
        _ weaponType: STOBeamWeaponType, 
        _ damageType: STOEnergyDamageType, 
        _ mark: STOMark, 
        _ quality: STOQuality
    ) {
        super.init(.OmnidirectionalBeamArray, .Antiproton, mark, quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: STOWeaponCodingKeys.self)
        try container.encode(String(describing: type(of: self)), forKey: .class)
        try super.encode(to: encoder)
    }

    public override var description: String {
        return "Ancient \(weaponType) - Mk \(mark) \(quality)"
    }
}
