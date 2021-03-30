public class PhotonTorpedo: KineticTorpedoWeapon {
    public init(_ mark: Mark, _ quality: Quality) {
        super.init(.Standard, .Photon, mark, quality)
    }

    internal required init(
        _ weaponType: TorpedoWeaponType, 
        _ damageType: TorpedoKineticDamageType, 
        _ mark: Mark, 
        _ quality: Quality
    ) {
        super.init(.Standard, .Photon, mark, quality)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("This shouldn't ever be used")
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: WeaponCodingKeys.self)
        try container.encode(String(describing: type(of: self)), forKey: .class)
        try super.encode(to: encoder)
    }
}
