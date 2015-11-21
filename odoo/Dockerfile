FROM debian:jessie
MAINTAINER Guewen Baconnier

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
            node-less \
            node-clean-css \
            python \
            python-pyinotify \
            python-renderpm \
            python-support \
            python-dateutil \
            python-decorator \
            python-docutils \
            python-feedparser \
            python-imaging \
            python-jinja2 \
            python-ldap \
            python-libxslt1 \
            python-lxml \
            python-mako \
            python-mock \
            python-openid \
            python-passlib \
            python-psutil \
            python-psycopg2 \
            python-pybabel \
            python-pychart \
            python-pydot \
            python-pyparsing \
            python-pypdf \
            python-reportlab \
            python-requests \
            python-suds \
            python-tz \
            python-vatnumber \
            python-vobject \
            python-werkzeug \
            python-xlwt \
            python-yaml \
            python-simplejson \
            python-matplotlib \
            antiword \
            graphviz \
            ghostscript \
            postgresql-client \
            python-gevent \
            poppler-utils \
        && curl -o wkhtmltox.deb -SL http://nightly.odoo.com/extra/wkhtmltox-0.12.1.2_linux-jessie-amd64.deb \
        && echo '40e8b906de658a2221b15e4e8cd82565a47d7ee8 wkhtmltox.deb' | sha1sum -c - \
        && dpkg --force-depends -i wkhtmltox.deb \
        && apt-get -y install -f --no-install-recommends \
        && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false npm \
        && rm -rf /var/lib/apt/lists/* wkhtmltox.deb

# Install Odoo
ENV ODOO_VERSION 9.0

RUN useradd -m odoo && adduser odoo sudo

COPY ./odoo /odoo
COPY ./odoo-extra /odoo-extra

# Copy entrypoint script and Odoo configuration file
COPY ./etc/openerp-server.conf /etc/odoo/
RUN chown odoo /etc/odoo/openerp-server.conf

# Mount /var/lib/odoo to allow restoring filestore
# And share nginx configuration so the nginx container can read it
VOLUME ["/data/odoo", "/repositories/odoo-extra/runbot/static/nginx"]

# Expose Odoo services
EXPOSE 8069 8071

# Set the default config file
ENV OPENERP_SERVER /etc/odoo/openerp-server.conf

# Set default user when running the container
# deactivated due to write errors in the data volume
# see: http://stackoverflow.com/questions/23544282/what-is-the-best-way-to-manage-permissions-for-docker-shared-volumes
# USER odoo

WORKDIR "/odoo"
ENTRYPOINT ["./odoo.py"]
# ENTRYPOINT ["./odoo-entrypoint.sh"]
CMD []
