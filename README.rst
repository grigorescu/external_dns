Zeek Package for External DNS
================================================

.. image:: https://travis-ci.com/grigorescu/external_dns.svg?branch=master
   :target: https://travis-ci.com/grigorescu/external_dns
   :alt: Build Status

.. image:: https://coveralls.io/repos/github/grigorescu/external_dns/badge.svg?branch=master
   :target: https://coveralls.io/repos/github/grigorescu/external_dns?branch=master
   :alt: Coverage Status


.. image:: https://img.shields.io/github/license/grigorescu/external_dns)
   :target: :doc:`LICENSE <./LICENSE>`
   :alt: BSD license


![GitHub](

Raises a notice when a client is observed querying an external DNS server

Getting Started
---------------

These instructions will get you a copy of the package up and running on your Zeek cluster. See development for notes on how to install the package in order to hack on or contribute to it.

Prerequisites
-------------

This is a package designed to run with the [Zeek Network Security Monitor](https://zeek.org). First, [get Zeek](https://zeek.org/get-zeek/). We strive to support both the current feature and LTS releases.

The recommended installation method is via the [Zeek package manager, zkg](https://docs.zeek.org/projects/package-manager/en/stable/). On any recent system, run `pip install zkg`. After installation, run `zkg autoconfig`. For more information, see the [zkg documentation](https://docs.zeek.org/projects/package-manager/en/stable/quickstart.html).

Installing
----------

To install the package, run:

```
zkg install https://github.com/grigorescu/external_dns
```

If this is being installed on a cluster, install the package on the manager, then deploy it via: 

```
zeekctl deploy
```

Running the tests
-----------------

`zkg` will run the test suite before installing. To manually run the tests, go into the `tests` directory, and run `make`.

Contributing
------------

Please read [CONTRIBUTING.md](./docs/CONTRIBUTING.md) for details on how to contribute.

Versioning
----------

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](../../tags). 

Credits
-------


* Justin Azoff <jazoff@illinois.edu>


See also the list of [contributors](contributors) who participated in this project.

License
-------

This project is licensed under the BSD license. See the [LICENSE](LICENSE) file for details.

Acknowledgments
---------------

* ESnet team for Zeek Package Cookie Cutter
