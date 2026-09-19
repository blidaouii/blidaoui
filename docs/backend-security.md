# Backend security architecture

The client must treat Firestore documents as untrusted input. A production backend should:

- Allow only authenticated users to create/join rooms.
- Validate room membership and turn ownership in Cloud Functions or another trusted server.
- Generate dice values server-side and store an idempotency key per command.
- Validate legal moves against the authoritative state and reject stale revisions.
- Enforce room lifecycle, presence heartbeat, reconnect grace periods, and chat moderation limits.
- Keep rewards, coins, XP, leaderboards, and achievements server-authoritative.
- Deny client writes to protected progression fields through Firestore rules.

No Firebase credentials or service-account keys belong in this Flutter repository.
