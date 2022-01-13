#!/bin/bash
#
# swagger.sh
# Use Swagger Codegen to generate Swift models from a Swagger spec.
#

# Repository name of the Swagger Codegen project
SWAGGER_CODEGEN_REPO_NAME="Swagger Codegen"

# Repository URL of the Swagger Codegen project
SWAGGER_CODEGEN_REPO_URL="https://github.com/swagger-api/swagger-codegen"

# Command of Swagger Codegen
SWAGGER_CODEGEN_COMMAND="swagger-codegen"

# Check Swagger Codegen is installed
if ! [ -x "$(command -v ${SWAGGER_CODEGEN_COMMAND})" ]; then
    # Require Swagger Codegen installation
    echo "Please install ${SWAGGER_CODEGEN_REPO_NAME} from: ${SWAGGER_CODEGEN_REPO_URL}"
    exit 1
fi

# Check a Swagger spec url is provided as argument
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <SwaggerSpecURL>"
    exit 1
fi

# Execute Swagger Codegen
mkdir -p "${SWAGGER_CODEGEN_REPO_NAME}"
${SWAGGER_CODEGEN_COMMAND} generate -i $1 -l swift5 -o "${SWAGGER_CODEGEN_REPO_NAME}"
