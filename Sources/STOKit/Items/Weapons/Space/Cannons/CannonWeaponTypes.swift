extension CannonWeapon {
    internal static let specialTypes: [String: CannonWeapon.Type] = {
        return _specialTypes.reduce([String: CannonWeapon.Type]()) { (dict, type) -> [String: CannonWeapon.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    private static let _specialTypes: [CannonWeapon.Type] = [
        CannonWeapon.self,
        PhaserQuadCannons.self
    ]
}
