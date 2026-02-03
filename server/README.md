# 🐺 Server Scripts

This folder is reserved for future server-side scripts.

## Current Status

LXR-Mirror is currently a **client-side only** resource. All functionality runs on the client for optimal performance and minimal server load.

## Future Enhancements

Potential server-side features that may be added:
- Server-side state validation
- Item requirement verification (server-side inventory checks)
- Usage logging to database
- Discord webhook integration for monitoring
- Admin commands for managing mirror access
- Server-wide mirror statistics

## Why Client-Side?

The mirror system is client-only because:
- **Performance** - No server overhead, zero network traffic
- **Simplicity** - No complex client-server synchronization needed
- **Privacy** - Player camera state stays on their client
- **Latency** - Instant response with no network delays

If your use case requires server-side validation, the framework adapter in `shared/framework.lua` is designed to easily support server-side extensions.

---

**© 2026 iBoss21 / The Lux Empire | wolves.land**
