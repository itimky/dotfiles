# Homebrew
export PATH="/opt/homebrew/bin:${PATH}"

export CFLAGS="-I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include -L$(brew --prefix libpq)/include"
export CPPFLAGS="-I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include -L$(brew --prefix libpq)/include"
export LDFLAGS="-L$(brew --prefix readline)/lib -L$(brew --prefix openssl)/lib -L$(brew --prefix libpq)/lib"
