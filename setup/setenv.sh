GUIX_PROFILE="$HOME/guix/profiles/aoc"
. "$GUIX_PROFILE/etc/profile"

# We assume the default guix profile has nss-certs and glibc-locals installed

# git cert use
export SSL_CERT_DIR="$HOME/.guix-profile/etc/ssl/certs"
export SSL_CERT_FILE="$HOME/.guix-profile/etc/ssl/certs/ca-certificates.crt"
export GIT_SSL_CAINFO="$SSL_CERT_FILE"
# avoid guile locale warnings
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"

DIR=`dirname "$(readlink -f "$0")"`
# Avoid foreign distro emacs init
alias emacs="emacs -q -l $DIR/emacs.el"
