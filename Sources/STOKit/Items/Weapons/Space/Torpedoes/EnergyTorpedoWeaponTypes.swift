extension EnergyTorpedoWeapon {
    internal static let specialTypes: [String: EnergyTorpedoWeapon.Type] = {
        return _specialTypes.reduce([String: EnergyTorpedoWeapon.Type]()) { (dict, type) -> [String: EnergyTorpedoWeapon.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    private static let _specialTypes: [EnergyTorpedoWeapon.Type] = [
        EnergyTorpedoWeapon.self,
    ]
}
