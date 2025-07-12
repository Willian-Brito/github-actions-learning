FROM mcr.microsoft.com/dotnet/aspnet:8.0 as Base

# Copy application files
COPY ./src/api ./src
COPY ./src/web ./src/wwwroot

# Set working directory
WORKDIR /src
EXPOSE 8080

# Run the app
ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "./Todo.Api.dll"]
