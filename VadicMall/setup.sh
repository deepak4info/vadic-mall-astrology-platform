#!/bin/bash
set -e
export PATH="$HOME/.dotnet:$PATH"
cd "$(dirname "$0")/src/VadicMall.Api"
dotnet restore
dotnet run --urls "http://0.0.0.0:5080"
