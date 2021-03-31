extension BeamWeapon {
    internal static let specialTypes: [String: BeamWeapon.Type] = {
        return _specialTypes.reduce([String: BeamWeapon.Type]()) { (dict, type) -> [String: BeamWeapon.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    private static let _specialTypes: [BeamWeapon.Type] = [
        AncientAntiprotonOmniBeamArray.self
    ]
}
