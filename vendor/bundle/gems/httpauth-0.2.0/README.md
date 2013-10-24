HTTPauth
======

HTTPauth is a library supporting the full HTTP Authentication protocol as specified in RFC 2617; both Digest Authentication and Basic Authentication. We aim to make HTTPAuth as compliant as possible.

HTTPAuth is built to be completely agnostic of the HTTP implementation. If you have access to your webserver's headers you can use this library to implement authentication.

This project is currently under development, don't use it in mission critical applications.

## Getting started

If you want to implement authentication for your application you should probably start by looking at the various examples. In the examples directory is an implementation of an HTTP client and server, you can use these to test your implementation. The examples are basic implementations of the protocol.

## Limitations

Currently the library doesn't check for consistency of the directives in the various headers, this means that implementations using this library can be vulnerable to request replay attacks. This will obviously be addressed before the final release.

## Plugins

### Ruby on Rails

A plugin for Ruby on Rails can be found here:

https://fngtps.com/svn/rails-plugins/trunk/digest_authentication

## Known client implementation issues

### Safari

Safari doesn't understand and parse the algorithm and qop directives correctly. For instance: it sends qop=auth as qop="auth" and when multiple qop values are suggested by the server, no authentication is triggered.

### Internet Explorer

The qop and algorithm bug quoting bugs are also present in IE.

IE doesn't use the full URI for digest calculation, it chops off the query parameters. So a request on /script?q=a will response with uri='/script'.

## Known server implementation issues

Apache 2.0 sends Authorization-Info headers without a nextnonce directive.