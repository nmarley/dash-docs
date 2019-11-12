FROM ruby:2.5

ENV BITCOINORG_BUILD_TYPE=deployment
ENV DOXYFILE=Doxyfile-dashdocs

WORKDIR /build

RUN apt update && \
  apt install -y flex bison build-essential graphviz doxygen && \
  rm -fr /var/lib/apt/lists/*

RUN gem update --system && \
  gem install bundler

COPY . .

RUN bundle install

RUN make travis

# Static site should be in /build/_site
# Can use docker cp to extract

CMD ["/bin/bash"]
