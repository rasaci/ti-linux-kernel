#!/bin/bash
DIR="custom_patches"

for p in $DIR/*.patch; do
    echo "────────────────────────────────────────────"
    echo "🔍 Verificando parche: $p"
    echo "────────────────────────────────────────────"

    # 1. ¿Se puede aplicar?
    if patch -p1 --dry-run < $p >/dev/null 2>&1; then
        echo "🟡 NO ESTÁ aplicado (se puede aplicar)."
        continue
    fi

    # 2. ¿Se puede revertir?
    if patch -p1 --dry-run -R < $p >/dev/null 2>&1; then
        echo "🟢 YA ESTÁ APLICADO (se puede revertir)."
        continue
    fi

    # 3. Caso mixto
    echo "🔴 MIXTO: parte aplicada y parte modificada."
    echo "   Esto pasa cuando el código ya incluye el fix pero no coincide al 100%."
done
