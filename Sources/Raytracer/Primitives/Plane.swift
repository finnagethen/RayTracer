class Plane: Primitive {
    let offset: Vec3
    let normal: Vec3
    let material: Material

    init(offset: Vec3, normal: Vec3, material: Material) {
        self.offset = offset
        self.normal = normal.normalized()
        self.material = material
    }

    func intersect(ray: Ray) -> Intersection? {
        let denominator = normal.dot(other: ray.direction)
        
        // devide by zero check
        let epsilon = 1e-5
        if abs(denominator) < epsilon {
            return nil // ray is parallel to the plane
        }

        let numerator = normal.dot(other: offset.sub(other: ray.origin))
        let t = numerator / denominator
        if t < 0 {
            return nil // intersection is behind the ray origin
        }

        return Intersection(
            point: ray.at(t: t),
            normal: normal,
            distance: t,
            material: material
        )
    }
}
