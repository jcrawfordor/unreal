unreal
======

This is a simple and not particular elegant Docker container to run Unreal
4.x. The configuration should be mounted via host volume at
`/root/unrealircd/conf`. UnrealIRCD does not run as root, although it's in
root's homedir because I am lazy.

Usage
-----

To start, you will need a complete and working configuration for unrealircd.
This can be a bit of an ordeal to create. The simplest method is to either
copy from the examples found in docs/conf in the Unreal 4.x source package, or
to use unreal's upgrade-conf command to upgrade an existing configuration for
a 3.2.x version of Unreal. Note that in both cases the config file will
include some other config files you need as well (e..g
`operclass.default.conf`), these can be found in docs/conf in the source
package.

Note that in Unreal 4.x the SSL certificate and key are expected to be
`server.cert.pem` and `server.key.pem` respectively in the configuration
directory. You may need to move them form where you had them in 3.2, if your
configuration enables SSL listening.

Once you have this configuration gathered up, put it in one directory and
provide that as a hostmount to the container at `/data/unrealircd/conf`. For example:

```
docker run -v /srv/unreal:/data/unrealircd/conf -p 6667:6667
jcrawfordor/unreal
```
