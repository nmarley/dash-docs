# Stage 1 : Build the static site
#
# This image is used as an intermediate step and can be cleaned up by Docker.
FROM ruby:2.5

ENV BITCOINORG_BUILD_TYPE=deployment
ENV DOXYFILE=Doxyfile-dashdocs

WORKDIR /build

RUN apt update && \
  apt install -y flex bison build-essential graphviz doxygen && \
  rm -fr /var/lib/apt/lists/*

RUN gem update --system && \
  gem install bundler

# Copy gemfiles first to avoid re-installing dependencies w/every file change
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY . .

RUN make all

# TODO: Doxygen

# Static site is now in /build/_site
CMD ["/bin/bash"]


# Stage 2: Copy out build results.
#
# Because Docker is able to clean up the intermediate image, the final image is
# reduced in size from 1.23GB to just 18.7MB.
FROM scratch
COPY --from=0 /build/_site /
CMD ["/bin/sh"]
