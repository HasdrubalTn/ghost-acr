FROM ghost:5-alpine

# Add app-insights globally
RUN  mkdir /opt/ai && \
        cd /opt/ai && \
        npm init -y && \
        npm install --production --save applicationinsights && \
        npm install --production --save applicationinsights-native-metrics

# Copy the ai-bootstrap.js file
COPY ai-bootstrap.js /opt/ai/

# Configure AI via ENV VARS
ENV APPINSIGHTS_INSTRUMENTATIONKEY c9ee2d5f-08d3-41ac-ad0d-bf378c759dc7
ENV APPLICATIONINSIGHTS_ROLE_NAME Frontend
ENV APPLICATIONINSIGHTS_ROLE_INSTANCE GhostInstance

# Lets use platform agnositic node method to load ai instead of monkey patching i.e. NODE_OPTIONS='--require "/opt/ai/ai-bootstrap.js"'
ENV NODE_OPTIONS='--require /opt/ai/ai-bootstrap.js'