unreal
======

This is a simple and not particular elegant Docker container to run Unreal
4.x. The configuration should be mounted via host volume at
`/root/unrealircd/conf`. UnrealIRCD does not run as root, although it's in
root's homedir because I am lazy.
