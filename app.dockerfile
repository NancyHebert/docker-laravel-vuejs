FROM php:7.0.4-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev \
    mysql-client libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install mcrypt pdo_mysql

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install Node and NPM 
RUN apt-get update \
  && apt-get install -y nodejs\
  && apt-get install -y yarn

# RUN apt-get install -y epel-release
RUN apt-get install -y pngquant
# RUN apt-get install -y libpng-devel

RUN npm cache clear --force
RUN rm -rf node_modules
RUN rm -rf package-lock.json
RUN npm install -g n
RUN npm install
