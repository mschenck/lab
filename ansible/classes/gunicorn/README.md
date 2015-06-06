gunicorn - parameterized ansible role
=====================================

Params
------

* name (**required**) - name of application
* app\_root (**required**) - path to application root
* uwsgi\_addr (optional) - defaults to "127.0.0.1"
* uwsgi\_port (optional) - defaults to 8000
