public class PhotonTorpedo: STOKineticTorpedoWeapon {
    public init(_ mark: STOMark, _ quality: STOQuality) {
        super.init(.Standard, .Photon, mark, quality)
    }

    internal required init(
        _ weaponType: STOTorpedoWeaponType, 
        _ damageType: STOTorpedoKineticDamageType, 
        _ mark: STOMark, 
        _ quality: STOQuality
    ) {
        super.init(.Standard, .Photon, mark, quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: STOWeaponCodingKeys.self)
        try container.encode(String(describing: type(of: self)), forKey: .class)
        try super.encode(to: encoder)
    }
}
