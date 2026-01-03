# RFC-0002: ACPN DID Method

## Syntax

did:acpn:<type>:<identifier>

## Supported Types

- content
- domain
- creator
- contract

## DID Document Requirements

- MUST be signed
- MUST include validity window
- MUST include integrity hash
- MUST bind domains and quorum

Unsigned DID documents are INVALID.
