FROM node:20-alpine

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci --omit=dev

# --- TEMPORARY: KEV demo ---------------------------------------------------
# Deliberately vulnerable JARs whose CVEs are in the CISA KEV catalog.
# Grype detects them; the dashboard should show KEV matches.
# REMOVE THIS BLOCK once the demo is done — it ships known-exploited CVEs.
#
#   log4j-core 2.14.1  -> CVE-2021-44228 (Log4Shell) + CVE-2021-45046  [both KEV]
#   spring-beans 5.3.17 -> CVE-2022-22965 (Spring4Shell)              [KEV]
RUN wget -q -O /usr/src/app/log4j-core-2.14.1.jar \
      https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.14.1/log4j-core-2.14.1.jar && \
      
# ---------------------------------------------------------------------------

USER node

COPY . ./

EXPOSE 3000

CMD ["node", "index.js"]