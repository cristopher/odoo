FROM ubuntu:14.04
MAINTAINER Odoo S.A. <info@odoo.com>

USER root

RUN apt-get update -y
RUN apt-get upgrade -y
RUN install -y sudo
RUN useradd -m -g sudo -s /bin/bash odoo
apt-get install -y python-pip \
                   git vim mercurial \
                   ghostscript \
		   python-gevent \
		 python-dev \
		 freetds-dev \
		 python-matplotlib \
		 font-manager \
		 swig \
		 libffi-dev \
		 libssl-dev \
		 python-m2crypto \
		 python-httplib2 \
		 libxml2-dev \
		 libxslt-dev \
		 python-dev \
		 lib32z1-dev \
		 liblz-dev \
		 libcups2-dev
                 
RUN pip install urllib3
RUN pip install cchardet
RUN pip install dicttoxml
RUN pip install pysftp

USER odoo
WORKDIR /home/odoo
RUN mkdir ~/odoo-dev
WORKDIR /home/odoo/odoo-dev
RUN mkdir extra-addons
RUN git clone https://github.com/odoo/odoo.git -b 8.0
RUN ./odoo/odoo.py setup_deps
RUN ./odoo/odoo.py setup_pg

COPY ./entrypoint.sh 

# Expose Odoo services
EXPOSE 8069 8071

ENTRYPOINT ["/entrypoint.sh"]
