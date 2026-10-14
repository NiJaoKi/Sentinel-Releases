# One-time transfer setup

This repository contains release binaries and distribution metadata only. Application source remains private. Publication copies exactly six existing, tested assets and compares their approved SHA-256 hashes before and after upload. It never executes the downloaded installer.

To allow the transfer, create a short-lived fine-grained GitHub personal access token:

1. Open https://github.com/settings/personal-access-tokens/new.
2. Resource owner: NiJaoKi. Repository access: Only select repositories → Sentinel.
3. Repository permissions: Contents → Read-only. No write permissions are needed.
4. Set a short expiration (for example, seven days).
5. Add the token at https://github.com/NiJaoKi/Sentinel-Releases/settings/secrets/actions/new with name `SOURCE_RELEASE_TOKEN`.
6. Rerun the failed “Publish verified Windows Alpha” job in Actions.

Do not paste the token into chat, issues or files. After successful publication, delete the secret and revoke the token. It is only required for this transfer, never by installed Sentinel or people downloading the release. Publishing uses this public repository's separate built-in GitHub Actions token.

If publication stops after creating a draft, inspect that draft before retrying: the workflow deliberately refuses to replace an existing release. Automatic updates inside the application require a separate authenticated update design and are not supplied by this workflow.
