FROM ruby:2.1

RUN mkdir /app
RUN mkdir /app/bin
WORKDIR /app
ENV PATH=/app/bin:${PATH}

ADD Gemfile Gemfile.lock /app/
RUN bundle install -j 8
ADD export-org-teams.rb /app/bin/

ENTRYPOINT [ "/app/bin/export-org-teams.rb" ]