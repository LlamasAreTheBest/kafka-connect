#!/bin/bash -e

#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

if [[ -z "$KAFKA_BOOTSTRAP_SERVERS" ]]; then
    echo "ERROR: missing mandatory config: KAFKA_BOOTSTRAP_SERVERS"
    exit 1
fi

if [[ -z "$KAFKA_GROUP_ID" ]]; then
    echo "ERROR: missing mandatory config: KAFKA_GROUP_ID"
fi

echo $KAFKA_BOOTSTRAP_SERVERS

#Issue newline to config file, in case there is not one already
echo "" >> "$KAFKA_HOME/config/connect-distributed.properties"

(
    function updateConfig() {
        key=$1
        value=$2
        file=$3

        # Omit $value here, in case there is sensitive information
        echo "[Configuring] '$key' in '$file'"

        # If config exists in file, replace it. Otherwise, append to file.
        if grep -E -q "^#?$key=" "$file"; then
            sed -r -i "s@^#?$key=.*@$key=$value@g" "$file" #note that no config values may contain an '@' char
        else
            echo "$key not found in $file! $key will be added"        # added 29.10.2020
            echo "$key=$value" >> "$file"
        fi
    }

    # Fixes #312
    # KAFKA_VERSION + KAFKA_HOME + grep -rohe KAFKA[A-Z0-0_]* /opt/kafka/bin | sort | uniq | tr '\n' '|'
    EXCLUSIONS="|KAFKA_VERSION|KAFKA_HOME|"

    # Read in env as a new-line separated array. This handles the case of env variables have spaces and/or carriage returns. See #313
    IFS=$'\n'
    for VAR in $(env)
    do

        env_var=$(echo "$VAR" | cut -d= -f1)
        if [[ "$EXCLUSIONS" = *"|$env_var|"* ]]; then
            echo "Excluding $env_var from broker config"
            continue
        fi

        if [[ $env_var =~ ^KAFKA_ ]]; then
            kafka_name=$(echo "$env_var" | cut -d_ -f2- | tr '[:upper:]' '[:lower:]' | tr _ .)
            updateConfig "$kafka_name" "${!env_var}" "$KAFKA_HOME/config/connect-distributed.properties"
        fi

    done
)

#cat $KAFKA_HOME/config/connect-distributed.properties

exec "$KAFKA_HOME/bin/connect-distributed.sh" "$KAFKA_HOME/config/connect-distributed.properties"
