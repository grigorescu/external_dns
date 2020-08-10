##! Raises a notice when a client is observed querying an external DNS server

@load base/frameworks/notice
@load base/protocols/dns

module DNS;

export {

	redef record Info += {
		## This is an outbound query
		is_external: bool &default=F;
		## Country code of external DNS server
		cc: string &log &optional;
	};

	## Ignore the following servers
	option ignore_external: set[subnet] = {
		8.8.4.4/32, #google dns
		8.8.8.8/32, #google dns
		208.67.220.123/32, #opendns
		208.67.220.220/32, #opendns
		208.67.222.222/32, #opendns
	};

	redef enum Notice::Type += {
		## Indicates that a user is using an external DNS server
		External_DNS_Server,

		## Indicates that a user is using an external DNS server in
		## a foreign country.
		External_Foreign_DNS_Server
	};

	## Anything not in this list is considered a foreign country
	option local_countries: set[string] = {
		"US",
	};

}

function do_lookup(id: conn_id, loc: geo_location)
	{
	when (local hostname = lookup_addr(id$resp_h))
		{
		local note = External_DNS_Server;
		local nmsg = fmt("An external DNS server is in use %s(%s)", id$resp_h, hostname);

		if(loc?$country_code && loc$country_code !in local_countries)
			{
			note = External_Foreign_DNS_Server;
			nmsg = fmt("An external foreign(%s) DNS server is in use %s(%s).",
			           loc$country_code, id$resp_h, hostname);
			}

		local ident = fmt("%s-%s", id$orig_h, id$resp_h);
		NOTICE([$note=note,
		        $msg=nmsg,
		        $sub=hostname,
		        $identifier=ident,
		        $remote_location=loc,
		        $suppress_for=1day,
		        $id=id]);
		}
	}

event dns_request(c: connection, msg: dns_msg, query: string, qtype: count, qclass: count)
	{
	if(!c?$dns)
		return;

	local rec = c$dns;
	if(!rec$RD)
		return;

	local orig_h = rec$id$orig_h;
	local resp_h = rec$id$resp_h;

	#is this an outbound query
	if(!Site::is_local_addr(orig_h) || Site::is_local_addr(resp_h))
		return;

	if(orig_h in ignore_external || resp_h in ignore_external)
		return;

	rec$is_external=T;

	local loc = lookup_location(resp_h);

	rec$cc = "";
	if(loc?$country_code)
		rec$cc = loc$country_code;

	do_lookup(c$id, loc);
	}

event zeek_init()
	{
	Log::add_filter(DNS::LOG, [$name = "external-dns",
	                $path = "external_dns",
	                $exclude = set("uid", "proto", "trans_id","qclass", "qclass_name", "qtype",
	                               "rcode", "QR","AA","TC","RD","RA","Z","answers","TTLs"),
	                $pred(rec: DNS::Info) = { return rec$is_external; }]);
	}
