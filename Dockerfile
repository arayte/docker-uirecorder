FROM selenium/standalone-chrome-debug
LABEL name="docker uirecorder"

ENV NVM_VERSION v0.29.0
ENV NODE_VERSION v14.3.0

USER 0

# Set the tests directory environment variable
ENV TESTS_DIR /home/seluser/test
RUN mkdir -p $TESTS_DIR && chmod 777 $TESTS_DIR

ENV NVM_DIR /home/seluser/.nvm
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
USER seluser
# Install NVM
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/${NVM_VERSION}/install.sh | bash 
RUN . $NVM_DIR/nvm.sh && \
   nvm install $NODE_VERSION && \
   nvm use --delete-prefix $NODE_VERSION
ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/$NODE_VERSION/bin:$TESTS_DIR:$PATH
RUN npm install uirecorder mocha -g
WORKDIR $TESTS_DIR 
