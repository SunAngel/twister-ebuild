# Created by Vladimir Goshev

EAPI=4

inherit eutils autotools git-2

DESCRIPTION="Twister daemon"
HOMEPAGE="http://twister.net.co/"
EGIT_REPO_URI="https://github.com/miguelfreitas/twister-core.git"
S=${WORKDIR}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~arm ~amd64"
IUSE="sse2 upnp"

DEPEND=">=dev-libs/boost-1.44
	dev-libs/glib
	dev-libs/openssl
	sys-libs/db:4.8
	upnp? ( net-libs/miniupnpc )"

RDEPEND=""

src_unpack() {
	git-2_src_unpack
}

src_prepare() {
	./autotool.sh || die "Autogen failed"
}

src_configure() {
	econf $(use_enable sse2) \
		$(use_enable upnp) \
		|| die "econf failed"
		
	sed -i 's,^DEFAULT_INCLUDES = \(.*\)$,DEFAULT_INCLUDES = \1 -I/usr/include/db4.8/,' Makefile
	
}

src_install() {
	cp "${S}/twisterd" "${D}/" || die "Install failed!"
}
