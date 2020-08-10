##! Prints notices to stdout, so that we can display the output in the docs.

@load base/frameworks/notice

hook Notice::policy(n: Notice::Info) &priority=10000
	{
	print fmt("Notice %s: ident=%s", n$note, n$identifier);
	}
