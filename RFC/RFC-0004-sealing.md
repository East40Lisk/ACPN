# RFC-0004: Sealed Content Descriptor (SCD)

## Purpose

Bind content identity to multiple storage backends while preserving revocation authority.

## Integrity Rule

keccak256(contentId || ipfs.cid || arweave.txId)

Mismatch invalidates execution.
