#!/bin/bash
# Detached OpenPGP signature for release artifacts. Creates ${path}.asc.
# No-op if EDDIESIGNINGDIR/eddie.gpg-signing.passphrase is not set (e.g. public CI).

set -euo pipefail

if [ "${1-}" = "" ] || [ ! -f "${1}" ]; then
	echo "sign-openpgp.sh: missing or non-existent file" >&2
	exit 1
fi

if ! test -f "${EDDIESIGNINGDIR:-/none}/eddie.gpg-signing.passphrase"; then
	exit 0
fi

PASSPHRASE=$(cat "${EDDIESIGNINGDIR}/eddie.gpg-signing.passphrase")
export GPG_TTY=$(tty 2>/dev/null || true)
gpg --batch --yes --pinentry-mode loopback --passphrase "${PASSPHRASE}" \
	--detach-sign --armor -u "maintainer@eddie.website" -o "${1}.asc" "${1}"
gpg --verify "${1}.asc" "${1}"
