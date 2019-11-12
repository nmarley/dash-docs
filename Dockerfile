FROM ruby:2.5

WORKDIR /build

RUN apt update && \
  apt install -y flex bison build-essential graphviz

# TODO: merge w/above
RUN apt install -y doxygen

RUN gem update --system && \
  gem install bundler

COPY . .

RUN bundle install

RUN make travis


ENV BITCOINORG_BUILD_TYPE=deployment
ENV DOXYFILE=Doxyfile-dashdocs

# build ...

CMD ["/bin/bash"]
