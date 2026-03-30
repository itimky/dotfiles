# Homebrew
if [[ -z "${HOMEBREW_PREFIX}" ]] && command -v brew >/dev/null 2>&1; then
	export HOMEBREW_PREFIX="$(brew --prefix)"
fi

if [[ -z "${HOMEBREW_PREFIX}" ]]; then
	return 0
fi

export PATH="${HOMEBREW_PREFIX}/bin:${PATH}"

READLINE_PREFIX="${HOMEBREW_PREFIX}/opt/readline"
OPENSSL_PREFIX="${HOMEBREW_PREFIX}/opt/openssl"
LIBPQ_PREFIX="${HOMEBREW_PREFIX}/opt/libpq"

SDK_INCLUDE=""
if [[ -n "${SDKROOT}" ]]; then
	SDK_INCLUDE="-I${SDKROOT}/usr/include"
fi

export CFLAGS="-I${READLINE_PREFIX}/include -I${OPENSSL_PREFIX}/include ${SDK_INCLUDE} -I${LIBPQ_PREFIX}/include"
export CPPFLAGS="-I${READLINE_PREFIX}/include -I${OPENSSL_PREFIX}/include ${SDK_INCLUDE} -I${LIBPQ_PREFIX}/include"
export LDFLAGS="-L${READLINE_PREFIX}/lib -L${OPENSSL_PREFIX}/lib -L${LIBPQ_PREFIX}/lib"
