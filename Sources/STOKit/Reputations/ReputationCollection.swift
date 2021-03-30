public struct ReputationCollection: Codable {
    public typealias Reputations = [Reputation]

    private var reputations: Reputations

    init() {
        self.reputations = ReputationOrganization.allCases
            .map { organization in
                Reputation(organization: organization)
            }
    }

    internal init(_ reputations: [Reputation]) {
        self.reputations = reputations
    }

    public subscript(organization: ReputationOrganization) -> Reputation {
        get {
            return reputations
                .filter({ $0.organization == organization })
                .first!
        }
        set {
            guard let index = reputations.firstIndex(where: { $0.organization == organization }) else { return }
            reputations[index] = newValue
        }
    }
}

extension ReputationCollection: Collection {
    public typealias Index = Reputations.Index
    public typealias Element = Reputations.Element

    public var startIndex: Index { return reputations.startIndex }
    public var endIndex: Index { return reputations.endIndex }

    public subscript(index: Index) -> Element {
        get { return reputations[index] }
    }

    public func index(after i: Index) -> Index {
        return reputations.index(after: i)
    }
}

extension ReputationCollection: CustomStringConvertible {
    public var description: String {
        return "\(reputations)"
    }
}
