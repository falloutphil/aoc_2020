GUIX_PROFILE="$HOME/guix/profiles/aoc"
. "$GUIX_PROFILE/etc/profile"

# git cert use
export SSL_CERT_DIR="$HOME/.guix-profile/etc/ssl/certs"
export SSL_CERT_FILE="$HOME/.guix-profile/etc/ssl/certs/ca-certificates.crt"
export GIT_SSL_CAINFO="$SSL_CERT_FILE"

DIR=`dirname "$(readlink -f "$0")"`
# Avoid foreign distro emacs init
alias emacs="emacs -q -l $DIR/emacs.el"
