# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Svorak layout files"
HOMEPAGE="http://aoeu.info/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+tty_svorak_a1 -tty_svorak_a5 -x11_svorak_a5"

RDEPEND=""
DEPEND=""

src_unpack() {
	mkdir ${S}
}

src_prepare() {
	if [ "$(use_enable tty_svorak_a1)" == "--enable-tty_svorak_a1" ]; then
		mkdir -p usr/share/keymaps/i386/dvorak/
		gzip -c ${FILESDIR}/tty/svorak.map > usr/share/keymaps/i386/dvorak/svorak.map.gz
	fi
	
	if [ "$(use_enable tty_svorak_a5)" == "--enable-tty_svorak_a5" ]; then
		mkdir -p usr/share/keymaps/i386/dvorak/
		gzip -c ${FILESDIR}/tty/svoraka5.map > usr/share/keymaps/i386/dvorak/svoraka5.map.gz
	fi
	
	if [ "$(use_enable x11_svorak_a5)" == "--enable-x11_svorak_a5" ]; then
		mkdir -p usr/share/X11/xkb/symbols
		cp ${FILESDIR}/x11/svoraka5 usr/share/X11/xkb/symbols/svoraka5
	fi
}

src_install() {
	cp -pPR usr ${D}
}

pkg_postinst() {
	if [ "$(use_enable tty_svorak_a1)" == "--enable-tty_svorak_a1" ]; then
		einfo 'The installed Svorak A1 for TTY is named "svorak" and you load it like this:'
		einfo ' $ loadkeys svorak'
		einfo
	fi
	
	if [ "$(use_enable tty_svorak_a5)" == "--enable-tty_svorak_a5" ]; then
		einfo 'The installed Svorak A5 for TTY is named "svoraka5" and you load it like this:'
		einfo ' $ loadkeys svoraka5'
		einfo
	fi
	
	if [ "$(use_enable x11_svorak_a5)" == "--enable-x11_svorak_a5" ]; then
		einfo 'The installed Svorak A5 for X11 is named "se_dvorak_a5"" and you load it like this:'
		einfo ' $ setxkbmap svoraka5'
		einfo
	fi
}

