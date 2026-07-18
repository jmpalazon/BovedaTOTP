#!/usr/bin/env bash
# Genera el instalador MSI a partir de la compilación de Neutralino.
# Requiere: msitools + wixl  (Linux/WSL:  apt install msitools wixl)
# Uso:  ./scripts/build-msi.sh 1.2.0
set -e
VERSION="${1:?Uso: build-msi.sh <version>}"
cd "$(dirname "$0")/.."
neu build --release
WORK=$(mktemp -d)
cp dist/BovedaTOTP/BovedaTOTP-win_x64.exe "$WORK/BovedaTOTP.exe"
cp dist/BovedaTOTP/resources.neu "$WORK/"
sed "s/Version=\"[0-9.]*\"/Version=\"$VERSION\"/" packaging/boveda.wxs > "$WORK/boveda.wxs"
( cd "$WORK" && wixl -a x64 -o "BovedaTOTP-$VERSION.msi" boveda.wxs )
mv "$WORK/BovedaTOTP-$VERSION.msi" dist/
echo "MSI generado en dist/BovedaTOTP-$VERSION.msi"
