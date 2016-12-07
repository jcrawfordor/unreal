# Unreal

This is a simple although not particularly elegant Docker container to run Unreal IRCd
4.x. The configuration should be mounted via host volume at `/root/unrealircd/conf`, 
and the administrator is otherwise left to their own devices as far as usage.

Unreal IRCd is compiled at build time and so can be updated by rebuilding the
container. I will trigger a rebuild whenever there are new releases, although
administrators will need to ensure that they re-pull the image from time to time.

## Usage

To start, you will need a complete and working configuration for unrealircd.
This can be a bit of an ordeal to create. The simplest method is to either
copy from the examples found in docs/conf in the Unreal 4.x source package, or
to use unreal's upgrade-conf command to upgrade an existing configuration for
a 3.2.x version of Unreal. Note that in both cases the config file will
include some other config files you need as well (e..g
`operclass.default.conf`), these can be found in docs/conf in the source
package.

Note that in Unreal 4.x the SSL certificate and key are expected to be
`server.cert.pem` and `server.key.pem` respectively in `ssl/` in the configuration
directory. You may need to move them from where you had them in 3.2, if your
configuration enables SSL listening.

Once you have this configuration gathered up, put it in one directory and
provide that as a hostmount to the container at `/data/unrealircd/conf`. For example:

```
docker run -v /srv/unreal:/data/unrealircd/conf -p 6667:6667
jcrawfordor/unreal
```
## Notes

UnrealIRCD's build and installation process is, in this author's opinion, an
autotools dumpster fire. A remarkable amount of frustration was involved in
building Unreal in-container and I could not get it to build at all in Alpine,
thus using a heavier-weight Debian container. UnrealIRCD's design is also
almost actively hostile to good system administration practice, so there are
some antipatterns in the way configuration is managed here.

## Pros/Cons

### Pros

  * Works
  * Simple design makes this container very simple and unlikely to break things

### Cons

  * No autoconfiguration, so this is best if you have an existing configuration or are
    willing to build configuration files yourself.
  * Debian image with in-container building results in a larger image size.
