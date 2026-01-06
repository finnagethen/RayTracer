class Sphere: Primitive {
    let center: Vec3
    let radius: Double
    let material: Material

    init(center: Vec3, radius: Double, material: Material) {
        self.center = center
        self.radius = radius
        self.material = material
    }

    func intersect(ray: Ray) -> Intersection? {
        let oc = ray.origin.sub(other: center)

        let a = ray.direction.dot(other: ray.direction)
        let b = 2.0 * ray.direction.dot(other: oc)
        let c = oc.dot(other: oc) - radius * radius

        let discriminant = b * b - 4 * a * c
        if discriminant < 0 {
            return nil
        }
        
        let sqrtDiscriminant = discriminant.squareRoot()
        let t1 = (-b - sqrtDiscriminant) / (2.0 * a)
        let t2 = (-b + sqrtDiscriminant) / (2.0 * a)
        
        let t = min(t1, t2)
        if t < 0 {
            return nil // intersection is behind the ray origin
        }

        let point = ray.at(t: t)
        let normal = point.sub(other: center).normalized()

        return Intersection(point: point, normal: normal, distance: t, material: material)
    }
}
