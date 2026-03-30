# Homebrew
export PATH="/opt/homebrew/bin:${PATH}"

export HOMEBREW_PREFIX="/opt/homebrew"

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
