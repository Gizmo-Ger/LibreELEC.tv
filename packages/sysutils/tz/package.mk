################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="tz"
PKG_VERSION="2016i"
PKG_ARCH="any"
PKG_LICENSE="Public Domain"
PKG_SITE="http://www.iana.org/time-zones"
PKG_URL="https://github.com/eggert/tz/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="system"
PKG_SHORTDESC="tzdata"
PKG_LONGDESC="tzdata"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="CC=$HOST_CC LDFLAGS="

makeinstall_target() {
  make TOPDIR="$INSTALL" install
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/share/zoneinfo
  mv $INSTALL/etc/zoneinfo/* $INSTALL/usr/share/zoneinfo

  rm -rf $INSTALL/etc
  mkdir -p $INSTALL/etc
    ln -sf /var/run/localtime $INSTALL/etc/localtime
}

post_install() {
  enable_service tz-data.service
}
