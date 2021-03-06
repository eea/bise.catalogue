# Install

* first, change version of desired ruby in .ruby-version

* now, install this chosen ruby

    rbenv install

* next, install bundle, this is used to install the gems in Gemfile

    gem install bundle

* now install the gems in Gemfile

    bundle install

* start rails with:

    rails server

## Debugging

* to debug a controller:

    gem install byebug

* add to the top of .rb file:

    require 'byebug`

* then, at any location, insert a line:

    byebug


# How to get a database dump of the Postgresql in production

The production database is installed as a dockerized service. You only get
access to the Postgresql files, not to a proper database.

The production database is configured to allow access unrestricted access from
all hosts, but it can't allow access from a shell opened in the docker image.

I've opened a shell to the db service:

    docker exec -it `docker-compose ps -q db | xargs` /bin/bash

I've edited the file /var/lib/postgresql/data/pg_hba.conf to allow unrestricted
connections from the local shell:

    local   all         all                               trust

Now I can list databases on the server:

    su - postgres -c psql


```
postgres=# \l
                                       List of databases
         Name         |  Owner   | Encoding |  Collation  |    Ctype    |   Access privileges
----------------------+----------+----------+-------------+-------------+-----------------------
 catalogue_production | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 postgres             | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0            | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres
                                                                        : postgres=CTc/postgres
 template1            | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres
                                                                        : postgres=CTc/postgres
(4 rows)
```

And I can dump the database:

    su - postgres -c pg_dump catalogue_production -f /tmp/out.sql

Installed openssh-clients to allow scp-ing the file out of docker

Then I can import the file to the local machine:

    psql catalogue_production -f out.sql

## Get ElasticSearch cluster in sync with the Postgresql data:

To regenerate the ElasticSearch indexes, use the reindex_elasticsearch.sh
script from this folder.
