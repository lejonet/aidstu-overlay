# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit git-2 eutils

DESCRIPTION="cowsay reimplemention for ponies"
HOMEPAGE="https://github.com/erkin/ponysay"

SRC_URI=""
EGIT_REPO_URI="git://github.com/erkin/ponysay.git"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="**"
IUSE="-info -bash-completion -fish-completion -zsh-completion"

DEPEND="app-arch/gzip
	info? ( sys-apps/texinfo )
	sys-devel/make
	sys-apps/sed"

RDEPEND="sys-apps/coreutils
	>=dev-lang/python-3.0
	fish-completion? ( || ( app-shells/fishfish app-shells/fish ) )
	zsh-completion?  ( app-shells/zsh )"

src_configure() {
	./configure --without-shared-cache                                                       \
		$(use_with bash-completion | sed -e 's/-completion//' -e 's/--with-bash//')      \
		$(use_with fish-completion | sed -e 's/-completion//' -e 's/--with-fish//')      \
		$(use_with zsh-completion  | sed -e 's/-completion//' -e 's/--with-zsh//')       \
		$(use_with info            | sed 's/--with-info//')
}

src_compile() {
	make
}

src_install() {
	emake install DESTDIR="${D}"
}
