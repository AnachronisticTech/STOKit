public class STOSingleCannon: STOCannonWeapon {
    public override init(_ type: STOEnergyDamageType, _ mark: STOMark, _ quality: STOQuality) {
        super.init(type, mark, quality)
    }

    public override var description: String {
        return "\(type) Cannon - Mk \(mark) \(quality)"
    }
}
