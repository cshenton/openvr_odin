# OpenVR Odin

OpenVR bindings generator for the Odin programming language.

I wanted to write some OpenVR code, and Valve provides a .json API repository describing their C FFI interfaces.
So this code (in `generator.odin`) generates a set of bindings.

Currently, the generated bindings only support windows, however adding other targets should be easy, as Valve ships
binaries for various platforms in [the OpenVR repository](https://github.com/ValveSoftware/openvr/tree/master/bin)

## Usage

Copy `openvr/` into your project tree and `import vr "path/to/openvr"` to start using the API. Ensure that
`openvr_api.dll` is included along with your shipped executable.

## Differences from the C API

The SteamVR C API has quite inconsistent naming conventions, so I've chosen to clean those up to make usage easier.
I don't change the case of the APIs, so they should still be searchable, but I remove `E` prefix for enum types,
redundant C enum prefixes, and the occasional `_t` struct suffix.

As a result, the odin API is much more uniform and, I find, easier to work with.

Another big difference is the string names for the interface versions, which get passed to `vr.GetGenericInterface`.
In the C/C++ APIs, these must be prefixed with `FnTable:`, otherwise they will return completely different vtables.
For me this undocumented, silently failing behaviour was too error prone, so my generated constants prepend that
`FnTable:` prefix, and can be used directly as in my example code.


## Example

There's a basic example in `example/`. It renders any connected devices and mirrors the right eye to a companion window.
To run the example code on windows, simply run `odin run example` from this directory.

![Example Image](img/hello_odin_openvr.png)
