#!/bin/sh -e
 
get_gfwlist()
{
	if [ ! -f /tmp/gfwlist.txt ]; then
		wget --no-check-certificate https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt -O /tmp/gfwlist.b64 >&2
		cat /tmp/gfwlist.b64 | base64 -d > /tmp/gfwlist.txt
		rm -f /tmp/gfwlist.b64
	fi
}

generate_china_banned()
{
	grep -vE '^\!|\[|^@@|(https?://){0,1}[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' /tmp/gfwlist.txt |
		sed 's#|##g; s#http:\/\/##; s#https:\/\/##; s#^\*\.##; s#^\.\+##; s#\/\*$##; s#\/\+$##; /\*/d' |
		grep '^[0-9a-zA-Z\.-]\+$' | grep '\.' > /tmp/tmp_banned.txt
	printf 'google.com\ngoogle.ad\ngoogle.ae\ngoogle.com.af\ngoogle.com.ag\ngoogle.com.ai\ngoogle.al\ngoogle.am\ngoogle.co.ao\ngoogle.com.ar\ngoogle.as\ngoogle.at\ngoogle.com.au\ngoogle.az\ngoogle.ba\ngoogle.com.bd\ngoogle.be\ngoogle.bf\ngoogle.bg\ngoogle.com.bh\ngoogle.bi\ngoogle.bj\ngoogle.com.bn\ngoogle.com.bo\ngoogle.com.br\ngoogle.bs\ngoogle.bt\ngoogle.co.bw\ngoogle.by\ngoogle.com.bz\ngoogle.ca\ngoogle.cd\ngoogle.cf\ngoogle.cg\ngoogle.ch\ngoogle.ci\ngoogle.co.ck\ngoogle.cl\ngoogle.cm\ngoogle.cn\ngoogle.com.co\ngoogle.co.cr\ngoogle.com.cu\ngoogle.cv\ngoogle.com.cy\ngoogle.cz\ngoogle.de\ngoogle.dj\ngoogle.dk\ngoogle.dm\ngoogle.com.do\ngoogle.dz\ngoogle.com.ec\ngoogle.ee\ngoogle.com.eg\ngoogle.es\ngoogle.com.et\ngoogle.fi\ngoogle.com.fj\ngoogle.fm\ngoogle.fr\ngoogle.ga\ngoogle.ge\ngoogle.gg\ngoogle.com.gh\ngoogle.com.gi\ngoogle.gl\ngoogle.gm\ngoogle.gp\ngoogle.gr\ngoogle.com.gt\ngoogle.gy\ngoogle.com.hk\ngoogle.hn\ngoogle.hr\ngoogle.ht\ngoogle.hu\ngoogle.co.id\ngoogle.ie\ngoogle.co.il\ngoogle.im\ngoogle.co.in\ngoogle.iq\ngoogle.is\ngoogle.it\ngoogle.je\ngoogle.com.jm\ngoogle.jo\ngoogle.co.jp\ngoogle.co.ke\ngoogle.com.kh\ngoogle.ki\ngoogle.kg\ngoogle.co.kr\ngoogle.com.kw\ngoogle.kz\ngoogle.la\ngoogle.com.lb\ngoogle.li\ngoogle.lk\ngoogle.co.ls\ngoogle.lt\ngoogle.lu\ngoogle.lv\ngoogle.com.ly\ngoogle.co.ma\ngoogle.md\ngoogle.me\ngoogle.mg\ngoogle.mk\ngoogle.ml\ngoogle.com.mm\ngoogle.mn\ngoogle.ms\ngoogle.com.mt\ngoogle.mu\ngoogle.mv\ngoogle.mw\ngoogle.com.mx\ngoogle.com.my\ngoogle.co.mz\ngoogle.com.na\ngoogle.com.nf\ngoogle.com.ng\ngoogle.com.ni\ngoogle.ne\ngoogle.nl\ngoogle.no\ngoogle.com.np\ngoogle.nr\ngoogle.nu\ngoogle.co.nz\ngoogle.com.om\ngoogle.com.pa\ngoogle.com.pe\ngoogle.com.pg\ngoogle.com.ph\ngoogle.com.pk\ngoogle.pl\ngoogle.pn\ngoogle.com.pr\ngoogle.ps\ngoogle.pt\ngoogle.com.py\ngoogle.com.qa\ngoogle.ro\ngoogle.ru\ngoogle.rw\ngoogle.com.sa\ngoogle.com.sb\ngoogle.sc\ngoogle.se\ngoogle.com.sg\ngoogle.sh\ngoogle.si\ngoogle.sk\ngoogle.com.sl\ngoogle.sn\ngoogle.so\ngoogle.sm\ngoogle.sr\ngoogle.st\ngoogle.com.sv\ngoogle.td\ngoogle.tg\ngoogle.co.th\ngoogle.com.tj\ngoogle.tk\ngoogle.tl\ngoogle.tm\ngoogle.tn\ngoogle.to\ngoogle.com.tr\ngoogle.tt\ngoogle.com.tw\ngoogle.co.tz\ngoogle.com.ua\ngoogle.co.ug\ngoogle.co.uk\ngoogle.com.uy\ngoogle.co.uz\ngoogle.com.vc\ngoogle.co.ve\ngoogle.vg\ngoogle.co.vi\ngoogle.com.vn\ngoogle.vu\ngoogle.ws\ngoogle.rs\ngoogle.co.za\ngoogle.co.zm\ngoogle.co.zw\ngoogle.cat\n' >> /tmp/tmp_banned.txt
	printf 'blogspot.ca\nblogspot.co.uk\nblogspot.com\nblogspot.com.ar\nblogspot.com.au\nblogspot.com.br\nblogspot.com.by\nblogspot.com.co\nblogspot.com.cy\nblogspot.com.ee\nblogspot.com.eg\nblogspot.com.es\nblogspot.com.mt\nblogspot.com.ng\nblogspot.com.tr\nblogspot.com.uy\nblogspot.de\nblogspot.gr\nblogspot.in\nblogspot.mx\nblogspot.ch\nblogspot.fr\nblogspot.ie\nblogspot.it\nblogspot.pt\nblogspot.ro\nblogspot.sg\nblogspot.be\nblogspot.no\nblogspot.se\nblogspot.jp\nblogspot.in\nblogspot.ae\nblogspot.al\nblogspot.am\nblogspot.ba\nblogspot.bg\nblogspot.ch\nblogspot.cl\nblogspot.cz\nblogspot.dk\nblogspot.fi\nblogspot.gr\nblogspot.hk\nblogspot.hr\nblogspot.hu\nblogspot.ie\nblogspot.is\nblogspot.kr\nblogspot.li\nblogspot.lt\nblogspot.lu\nblogspot.md\nblogspot.mk\nblogspot.my\nblogspot.nl\nblogspot.no\nblogspot.pe\nblogspot.qa\nblogspot.ro\nblogspot.ru\nblogspot.se\nblogspot.sg\nblogspot.si\nblogspot.sk\nblogspot.sn\nblogspot.tw\nblogspot.ug\nblogspot.cat\n' >> /tmp/tmp_banned.txt
	printf 'twimg.edgesuite.net\n' >> /tmp/tmp_banned.txt
	sort -u /tmp/tmp_banned.txt > /tmp/ol_banned.txt
	rm -f /tmp/tmp_banned.txt
}

generate_whitelist()
{
	grep '^@@' /tmp/gfwlist.txt |
		sed 's#^@@##; s#|##g; s#http:\/\/##; s#https:\/\/##; s#^\*\.##; s#^\.\+##; s#\/\*$##; s#\/\+$##; /\*/d' |
		grep '^[0-9a-zA-Z\.-]\+$' | grep '\.' > /tmp/tmp_whitelist.txt
	grep -v -x -f /tmp/ol_banned.txt /tmp/tmp_whitelist.txt | sort -u > /tmp/ol_whitelist.txt
	rm -f /tmp/tmp_whitelist.txt
}

get_gfwlist
generate_china_banned
generate_whitelist
