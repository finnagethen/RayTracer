struct Intersection {
    let point: Vec3
    let normal: Vec3
    let distance: Double
    let material: Material
}

protocol Primitive {
    func intersect(ray: Ray) -> Intersection?
}
