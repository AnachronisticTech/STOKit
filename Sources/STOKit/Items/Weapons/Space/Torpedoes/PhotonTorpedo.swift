public class PhotonTorpedo: KineticTorpedoWeapon {
    public convenience init(_ mark: Mark, _ quality: Quality) {
        self.init(.Standard, .Photon, mark, quality)
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
}
