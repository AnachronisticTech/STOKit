open class STOBeamWeapon: STOWeapon {
    public let mark: STOMark
    public let quality: STOQuality

    private let _type: STOEnergyDamageType!
    public var type: some STODamageType {
        _type
    }

    internal init(_ type: STOEnergyDamageType, _ mark: STOMark, _ quality: STOQuality) {
        self._type = type
        self.mark = mark
        self.quality = quality
    }

    public var description: String {
        return "Beam weapon"
    }
}
