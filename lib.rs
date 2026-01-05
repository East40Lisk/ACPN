use wasm_bindgen::prelude::*;
use web_sys::window;
use sha2::{Sha256, Digest};
use serde_json::Value;
use p256::ecdsa::{VerifyingKey, Signature, signature::Verifier};

/// Hashes data with SHA-256
fn hash_data(data: &[u8]) -> String {
    let mut hasher = Sha256::new();
    hasher.update(data);
    format!("{:x}", hasher.finalize())
}

/// Verifies a WebAuthn assertion signature (P256 ECDSA).
/// Returns true if valid.
#[wasm_bindgen]
pub fn verify_assertion(
    public_key_bytes: &[u8],      // SEC1-encoded from registry
    auth_data: &[u8],
    client_data_json: &[u8],
    signature_der: &[u8],
) -> bool {
    // Reconstruct signed message: authenticatorData || SHA256(clientDataJSON)
    let client_hash = Sha256::digest(client_data_json);
    let mut signed_data = Vec::with_capacity(auth_data.len() + 32);
    signed_data.extend_from_slice(auth_data);
    signed_data.extend_from_slice(&client_hash);

    // Load SEC1 public key
    let verifying_key = match VerifyingKey::from_sec1_bytes(public_key_bytes) {
        Ok(k) => k,
        Err(_) => return false,
    };

    // Parse DER signature
    let signature = match Signature::from_der(signature_der) {
        Ok(s) => s,
        Err(_) => return false,
    };

    // ECDSA verify
    verifying_key.verify(&signed_data, &signature).is_ok()
}

/// Validates sealed content package and checks enforcement rules.
/// Returns true if valid (ready for decryption/playback).
#[wasm_bindgen]
pub fn validate_content(
    content_json: &str,           // Manifest JSON (from your schemas)
    public_key_bytes: Option<&[u8]>, // Optional passkey pubkey for biometric gate
    auth_data: Option<&[u8]>,
    client_data_json: Option<&[u8]>,
    signature_der: Option<&[u8]>,
) -> Result<bool, JsValue> {
    let manifest: Value = serde_json::from_str(content_json)
        .map_err(|e| JsValue::from_str(&format!("Invalid JSON: {}", e)))?;

    // Domain lock check
    let current_domain = window()
        .ok_or(JsValue::from_str("No window context"))?
        .location()
        .hostname()?;
    let approved = manifest["approvedDomain"]
        .as_str()
        .ok_or(JsValue::from_str("Missing approvedDomain"))?;
    if current_domain != approved {
        return Ok(false);
    }

    // Optional biometric/passkey verification
    if let (Some(pk), Some(ad), Some(cd), Some(sig)) = 
        (public_key_bytes, auth_data, client_data_json, signature_der) {
        if !verify_assertion(pk, ad, cd, sig) {
            return Ok(false);
        }
    }

    // Revocation/oracle check placeholder (extend with JS interop for chain query)
    if manifest["revoked"].as_bool().unwrap_or(false) {
        return Ok(false);
    }

    // Tamper detection placeholder (compare contentHash)
    let expected_hash = manifest["contentHash"]
        .as_str()
        .ok_or(JsValue::from_str("Missing contentHash"))?;
    // In real use: hash actual payload and compare

    Ok(true)
}

/// Scrambles data buffer (self-destruct on invalid access)
#[wasm_bindgen]
pub fn scramble_buffer(data: &mut [u8]) {
    for byte in data.iter_mut() {
        *byte = 0; // Or random noise: *byte = js_sys::Math::random() as u8 * 255;
    }
}

/// Stretch: Mock IPFS CID generation
#[wasm_bindgen]
pub fn mock_ipfs_cid(data: &str) -> String {
    format!("ipfs://Qm{}", hash_data(data.as_bytes())[..46].to_string())
}