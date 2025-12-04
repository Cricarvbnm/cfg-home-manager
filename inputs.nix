# =====================================================
# For Unflake to Read
# Unflake does not expect inputs without any URL
# =====================================================

removeAttrs (import ./flake.nix).inputs [ "self" ]
