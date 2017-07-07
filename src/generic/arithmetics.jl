# arithmetics.jl
# Routines having to do with computations involving domains

(+)(domain::Domain{T}, x::S) where {T,S} = (+)(domain, convert_space(spacetype(T), x))

(*)(map::AbstractMap, domain::Domain) = map_domain(map, domain)

(*)(a::Number, domain::Domain{T}) where {T} = LinearMap{T}(1/a) * domain
(*)(domain::Domain, a::Number) = a*domain

(/)(domain::Domain{T}, a::Number) where {T} = LinearMap{T}(a) * domain


(+)(d::Domain, x::SVector{N,T}) where {N,T} = Translation(-x) * d

# This does not work because the embedding system can't handle it.
(+)(x::AbstractVector, d::Domain) = d+x

# Rotation around the origin
rotate(d::Domain2d, theta) = rotation_map(phi) * d

rotate(d::Domain3d, phi, theta, psi) = rotation_map(phi,theta,psi) * d
# Rotation around a fixed center.
rotate(d::Domain2d, theta, center::SVector{T}) where {T} = Translation(x) * rotation_map(phi) * Translation(-x) * d

rotate(d::Domain3d, phi, theta, psi, center::SVector{T}) where {T} = Translation(x) * rotation_map(phi,theta,psi) * Translation(-x) * d
