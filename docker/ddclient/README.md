ddclient
========

Pull
----

    docker pull mschenck/ddclient

Configuration
-------------

Expects a volume `/etc/ddclient` with you `ddclient.conf`.

Run
---

    docker run -v <source volume>:/etc/ddclient --name=ddclient ddclient:latest
