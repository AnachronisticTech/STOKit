open class STOTorpedo: STOWeapon {
    public var mark: STOMark
    public var quality: STOQuality

    private let _type: STOPhysicalDamageType
    public var type: some STODamageType {
        _type
    }

    internal init(_ type: STOPhysicalDamageType, _ mark: STOMark, _ quality: STOQuality) {
        self._type = type
        self.mark = mark
        self.quality = quality
    }

    public var description: String {
        return "Torpedo weapon"
    }
}
