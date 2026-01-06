class Ray {
    let origin: Vec3
    let direction: Vec3

    init(origin: Vec3, direction: Vec3) {
        self.origin = origin
        self.direction = direction.normalized()
    }

    func at(t: Double) -> Vec3 {
        return origin.add(other: direction.scale(scalar: t))
    }
}
