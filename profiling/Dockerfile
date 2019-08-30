FROM perl:5.28-stretch
RUN apt-get update && apt-get install wget tar
RUN wget https://github.com/darold/pgbadger/archive/v11.0.tar.gz && tar xzf v11.0.tar.gz
RUN cd pgbadger-11.0/ && perl Makefile.PL && make && make install
CMD bash
