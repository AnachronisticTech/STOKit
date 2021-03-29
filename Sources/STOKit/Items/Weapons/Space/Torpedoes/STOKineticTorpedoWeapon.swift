open class STOKineticTorpedoWeapon: STOWeapon {
    public var mark: STOMark
    public var quality: STOQuality

    private let _weaponType: STOTorpedoWeaponType!
    public var weaponType: some STOWeaponType {
        _weaponType
    }

    private let _damageType: STOTorpedoKineticDamageType!
    public var damageType: some STODamageType {
        _damageType
    }

    public required init(
        _ weaponType: STOTorpedoWeaponType, 
        _ damageType: STOTorpedoKineticDamageType, 
        _ mark: STOMark, 
        _ quality: STOQuality
    ) {
        self._weaponType = weaponType
        self._damageType = damageType
        self.mark = mark
        self.quality = quality
    }

    public var description: String {
        return "\(weaponType)\(damageType) Torpedo Launcher - Mk \(mark) \(quality)"
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: STOWeaponCodingKeys.self)
        self.mark = try container.decode(STOMark.self, forKey: .mark)
        self.quality = try container.decode(STOQuality.self, forKey: .quality)
        self._weaponType = try container.decode(STOTorpedoWeaponType.self, forKey: ._weaponType)
        self._damageType = try container.decode(STOTorpedoKineticDamageType.self, forKey: ._damageType)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: STOWeaponCodingKeys.self)
        try container.encode(mark, forKey: .mark)
        try container.encode(quality, forKey: .quality)
        try container.encode(_weaponType, forKey: ._weaponType)
        try container.encode(_damageType, forKey: ._damageType)
    }

    internal static let specialTypes: [String: STOKineticTorpedoWeapon.Type] = {
        return _specialTypes.reduce([String: STOKineticTorpedoWeapon.Type]()) { (dict, type) -> [String: STOKineticTorpedoWeapon.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    private static let _specialTypes: [STOKineticTorpedoWeapon.Type] = [
        PhotonTorpedo.self
    ]
}
