# Using microsoft dotnet software development kit as 
# the build envionment.
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY ./ ./

# Build the app for production
RUN dotnet publish -c Release -o out

#------------------------------------------#

# Using microsoft aps net core 3.1 as hosting envionment
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS runtime-env
WORKDIR /srv

# COPY from build envionment into local container.
COPY --from=build-env /app .

# Expose the port intented for communications
EXPOSE 80

# Start running the app.
ENTRYPOINT ["dotnet", "out/API.dll"]
