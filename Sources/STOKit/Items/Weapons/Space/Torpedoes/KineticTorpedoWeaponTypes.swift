extension KineticTorpedoWeapon {
    internal static let specialTypes: [String: KineticTorpedoWeapon.Type] = {
        return _specialTypes.reduce([String: KineticTorpedoWeapon.Type]()) { (dict, type) -> [String: KineticTorpedoWeapon.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    private static let _specialTypes: [KineticTorpedoWeapon.Type] = [
        KineticTorpedoWeapon.self,
        PhotonTorpedo.self
    ]
}
