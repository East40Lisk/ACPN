// Solidity registry contract
// acpn_glue.js
export async function getPasskeySignature(challengeUint8, rpId) {
    // 1. Prepare the authentication options
    const publicKeyCredentialRequestOptions = {
        challenge: challengeUint8,
        allowCredentials: [], // Empty allows any passkey for this RP
        userVerification: "required",
        rpId: rpId,
        timeout: 60000,
    };

    try {
        // 2. This triggers the FaceID/TouchID prompt
        const assertion = await navigator.credentials.get({
            publicKey: publicKeyCredentialRequestOptions
        });

        // 3. Return the parts needed for the Registry handshake
        return {
            id: assertion.rawId,
            clientDataJSON: assertion.response.clientDataJSON,
            authenticatorData: assertion.response.authenticatorData,
            signature: assertion.response.signature
        };
    } catch (err) {
        console.error("Biometric handshake failed:", err);
        return null;
    }
}
