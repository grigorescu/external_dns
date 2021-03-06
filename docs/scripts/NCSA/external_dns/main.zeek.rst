:tocdepth: 3

NCSA/external_dns/main.zeek
===========================
.. zeek:namespace:: DNS

Raises a notice when a client is observed querying an external DNS server

:Namespace: DNS
:Imports: :doc:`base/frameworks/notice </scripts/base/frameworks/notice/index>`, :doc:`base/protocols/dns </scripts/base/protocols/dns/index>`

Summary
~~~~~~~
Runtime Options
###############
===================================================================== =========================================================
:zeek:id:`DNS::ignore_external`: :zeek:type:`set` :zeek:attr:`&redef` Ignore the following servers
:zeek:id:`DNS::local_countries`: :zeek:type:`set` :zeek:attr:`&redef` Anything not in this list is considered a foreign country
===================================================================== =========================================================

Redefinitions
#############
============================================ =
:zeek:type:`DNS::Info`: :zeek:type:`record`  
:zeek:type:`Notice::Type`: :zeek:type:`enum` 
============================================ =

Functions
#########
================================================ ==========================================================
:zeek:id:`DNS::do_lookup`: :zeek:type:`function` Given a connection and a location, will generate a notice.
================================================ ==========================================================


Detailed Interface
~~~~~~~~~~~~~~~~~~
Runtime Options
###############
.. zeek:id:: DNS::ignore_external

   :Type: :zeek:type:`set` [:zeek:type:`subnet`]
   :Attributes: :zeek:attr:`&redef`
   :Default:

      ::

         {
            8.8.8.8/32,
            208.67.220.220/32,
            208.67.222.222/32,
            208.67.220.123/32,
            8.8.4.4/32
         }


   Ignore the following servers

.. zeek:id:: DNS::local_countries

   :Type: :zeek:type:`set` [:zeek:type:`string`]
   :Attributes: :zeek:attr:`&redef`
   :Default:

      ::

         {
            "US"
         }


   Anything not in this list is considered a foreign country

Functions
#########
.. zeek:id:: DNS::do_lookup

   :Type: :zeek:type:`function` (id: :zeek:type:`conn_id`, loc: :zeek:type:`geo_location`) : :zeek:type:`void`

   Given a connection and a location, will generate a notice.
   
   .. btest:: do_lookup_us
   
       # @TEST-EXEC: btest-rst-cmd -o zeek NCSA/external_dns print_notices %INPUT > output
       # @TEST-EXEC: btest-diff-rst output
   
       local id = conn_id($orig_h=10.0.0.0, $orig_p=3/udp, $resp_h=8.8.8.8, $resp_p=53/udp);
       local loc = geo_location($country_code="US");
   
       print("DNS::do_lookup($country_code=\"US\") -> DNS::External_DNS_Server notice");
       DNS::do_lookup(id, loc);
   
   .. btest:: do_lookup_external
   
       # @TEST-EXEC: btest-rst-cmd -o zeek NCSA/external_dns print_notices %INPUT > output
       # @TEST-EXEC: btest-diff-rst output
   
       local id = conn_id($orig_h=10.0.0.0, $orig_p=3/udp, $resp_h=3.96.9.6, $resp_p=53/udp);
       local loc = geo_location($country_code="CA");
   
       print("DNS::do_lookup($country_code=\"CA\") -> DNS::External_Foreign_DNS_Server notice");
       DNS::do_lookup(id, loc);
   


