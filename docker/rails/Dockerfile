FROM ruby:3.2.2

WORKDIR /app

RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  libpq-dev && \
  curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn

COPY Gemfile .
COPY Gemfile.lock .
COPY .env .

RUN gem install bundler
RUN gem update bundler
RUN bundle install --jobs 5

# COPY package.json .
# COPY yarn.lock .
# RUN yarn install

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
