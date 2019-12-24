FROM adoptopenjdk/openjdk8:alpine-slim

ENV BUILD_TOOLS "29.0.2"
ENV TARGET_SDK "29"
ENV SDK_TOOLS "4333796"
ENV ANDROID_HOME "/opt/sdk"
ENV GRADLE_HOME /opt/gradle
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$GRADLE_HOME/bin
ENV GRADLE_VERSION "5.6.4"
ENV GRADLE_DOWNLOAD_SHA256 "1f3067073041bc44554d0efe5d402a33bc3d3c93cc39ab684f308586d732a80d"

# Install required dependencies
# Download and extract Android Tools
# Install SDK Packages
RUN apk add --no-cache bash git unzip wget \
 && apk add --virtual .rundeps $runDeps \
 && rm -rf /tmp/* \
 && rm -rf /var/cache/apk/* \
 && wget -q https://dl.google.com/android/repository/sdk-tools-linux-${SDK_TOOLS}.zip -O /tmp/tools.zip \
 && mkdir -p ${ANDROID_HOME} \
 && unzip -qq /tmp/tools.zip -d ${ANDROID_HOME} \
 && rm -v /tmp/tools.zip \
 && mkdir -p ~/.android/ \
 && touch ~/.android/repositories.cfg \
 && yes | ${ANDROID_HOME}/tools/bin/sdkmanager "--licenses" > /dev/null \
 && ${ANDROID_HOME}/tools/bin/sdkmanager "platform-tools" "extras;android;m2repository" "extras;google;m2repository" "extras;google;instantapps" | grep -v = || true \
 && ${ANDROID_HOME}/tools/bin/sdkmanager "--update" | grep -v = || true \
 && ${ANDROID_HOME}/tools/bin/sdkmanager "build-tools;${BUILD_TOOLS}" "platforms;android-${TARGET_SDK}" | grep -v = || true

## Install Gradle
RUN set -o errexit -o nounset \
 && echo "Downloading Gradle" \
 && wget --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
 && echo "Checking download hash" \
 && echo "${GRADLE_DOWNLOAD_SHA256} *gradle.zip" | sha256sum -c - \
 && echo "Installing Gradle" \
 && unzip gradle.zip \
 && rm gradle.zip \
 && mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" \
 && echo "Testing Gradle installation" \
 && gradle --version

WORKDIR /home/android