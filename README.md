# OpenVR Odin

OpenVR bindings generator for the Odin programming language.

I wanted to write some OpenVR code, and Valve provides a .json API repository describing their C FFI interfaces.
So this code (in `generator.odin`) generates a set of bindings.

## Using

Copy `openvr/` into your project tree and `import vr "path/to/openvr"` to start using the API.

## Example

I have some very basic example code in `example/`, I intend to expand this a bit with a basic OpenGL example. For
now I'm using these bindings in a separate non-public project, and they're working quite well!
