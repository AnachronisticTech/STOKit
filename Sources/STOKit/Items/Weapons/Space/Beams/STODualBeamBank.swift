public class STODualBeamBank: STOBeamWeapon {
    public override init(_ type: STOEnergyDamageType, _ mark: STOMark, _ quality: STOQuality) {
        super.init(type, mark, quality)
    }

    public override var description: String {
        return "\(type) Dual Beam Bank - Mk \(mark) \(quality)"
    }
}
