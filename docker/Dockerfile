FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y git cpanminus make gcc libxml2 libexpat1-dev libssl-dev   zlib1g-dev 
WORKDIR /opt
RUN git clone https://github.com/bioperl/Bio-DB-HIV.git
WORKDIR /opt/Bio-DB-HIV
RUN git checkout mb-installable
RUN perl Build.PL
RUN ./Build installdeps --cpan_client cpanm
RUN ./Build test
RUN ./Build install
ENTRYPOINT bp_hivq.pl
