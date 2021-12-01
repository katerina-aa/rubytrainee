FROM ruby:latest
RUN install bundler
RUN bundle install
COPY api/app.rb .
ENTRYPOINT ["ruby", "api/app.rb"]