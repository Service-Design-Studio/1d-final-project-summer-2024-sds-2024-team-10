# Use the official Ruby image from Docker Hub
FROM ruby:3.3.1

# Set the working directory in the container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential bash-completion libffi-dev tzdata git libvips libpq-dev nodejs npm && \
    npm install -g yarn

ARG MASTER_KEY
ENV RAILS_MASTER_KEY=${MASTER_KEY}

# Copy the application code into the container
COPY . /app

# Ensure /app/bin/rails and other scripts have execute permissions
RUN chmod -R +x /app/bin/*

# Copy Gemfile and Gemfile.lock and install gems
COPY Gemfile Gemfile.lock ./

RUN gem install bundler

# Add the current platform to the lockfile
RUN bundle lock --add-platform x86_64-linux

RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test'

RUN bundle install

# Set production environment variables
ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=true

# Precompile assets
RUN bundle exec rake assets:precompile

# Copy precompiled assets into the container
COPY public public/

# Expose port 8080 to the Docker host, so we can access Rails server
EXPOSE 8080

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "8080"]
