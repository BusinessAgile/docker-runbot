#!/bin/bash
set -e

if [ "$1" = "./sources/odoo.py" ]; then
  chown -R odoo .
  chown -R odoo /data/odoo
  exec gosu odoo "$@"
fi

exec "$@"
