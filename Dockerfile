FROM java:7u65
MAINTAINER Tony Kurc

RUN wget -O nifi-0.3.0-bin.tar.gz http://apache.mirrorcatalogs.com/nifi/0.3.0/nifi-0.3.0-bin.tar.gz
RUN tar -xzvf nifi-0.3.0-bin.tar.gz 

ADD logback.xml .
RUN mv -f logback.xml ./nifi-0.3.0/conf


VOLUME ["/output", "/flowconf", "/flowrepo",  "/contentrepo", "/databaserepo", "/provenancerepo"]

RUN sed -i 's/\.\/flowfile_repository/\/flowrepo/g' ./nifi-0.3.0/conf/nifi.properties
RUN sed -i 's/\.\/content_repository/\/contentrepo/g' ./nifi-0.3.0/conf/nifi.properties
RUN sed -i 's/\.\/conf\/flow\.xml\.gz/\/flowconf\/flow.xml.gz/' ./nifi-0.3.0/conf/nifi.properties
RUN sed -i 's/\.\/conf\/archive/\/flowconf\/archive/' ./nifi-0.3.0/conf/nifi.properties
RUN sed -i 's/\.\/database_repository/\/databaserepo/g' ./nifi-0.3.0/conf/nifi.properties
RUN sed -i 's/\.\/provenance_repository/\/provenancerepo/g' ./nifi-0.3.0/conf/nifi.properties



# web port
EXPOSE 8080

# listen port for web listening processor
EXPOSE 8081

WORKDIR nifi-0.3.0
CMD ["bin/nifi.sh", "run" ]
