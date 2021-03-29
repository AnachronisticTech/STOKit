open class STOBeamWeapon: STOWeapon {
    public let mark: STOMark
    public let quality: STOQuality

    private let _weaponType: STOBeamWeaponType!
    public var weaponType: some STOWeaponType {
        _weaponType
    }

    private let _damageType: STOEnergyDamageType!
    public var damageType: some STODamageType {
        _damageType
    }

    public required init(
        _ weaponType: STOBeamWeaponType, 
        _ damageType: STOEnergyDamageType, 
        _ mark: STOMark, 
        _ quality: STOQuality
    ) {
        self._weaponType = weaponType
        self._damageType = damageType
        self.mark = mark
        self.quality = quality
    }

    public var description: String {
        return "\(damageType) \(weaponType) - Mk \(mark) \(quality)"
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: STOWeaponCodingKeys.self)
        self.mark = try container.decode(STOMark.self, forKey: .mark)
        self.quality = try container.decode(STOQuality.self, forKey: .quality)
        self._weaponType = try container.decode(STOBeamWeaponType.self, forKey: ._weaponType)
        self._damageType = try container.decode(STOEnergyDamageType.self, forKey: ._damageType)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: STOWeaponCodingKeys.self)
        try container.encode(mark, forKey: .mark)
        try container.encode(quality, forKey: .quality)
        try container.encode(_weaponType, forKey: ._weaponType)
        try container.encode(_damageType, forKey: ._damageType)
    }

    internal static let specialTypes: [String: STOBeamWeapon.Type] = {
        return _specialTypes.reduce([String: STOBeamWeapon.Type]()) { (dict, type) -> [String: STOBeamWeapon.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    private static let _specialTypes: [STOBeamWeapon.Type] = [
        AncientAntiprotonOmniBeamArray.self
    ]
}
