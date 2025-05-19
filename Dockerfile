# Use the official Ruby base image with the correct version
FROM ruby:3.4.4

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs postgresql-client yarn curl && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Set environment variables
ENV RAILS_ENV=development \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

# Copy Gemfile early for caching layer
COPY Gemfile Gemfile.lock ./

# Install gem dependencies
RUN gem install bundler && bundle install

# Copy the entire project (after gems to leverage Docker cache)
COPY . .

# Remove stale server.pid if it exists (common issue when restarting dev containers)
RUN rm -f tmp/pids/server.pid

# Expose Rails default port
EXPOSE 3000

# Set default command to run the development server
CMD ["rails", "server", "-b", "0.0.0.0"]
