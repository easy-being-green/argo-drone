FROM virtuslab/scala-cli:latest AS build
RUN mkdir /app
COPY ["App.scala", "/app/"]
# speeds things up if compiled locally with
# scala-cli package App.scala -o app.jar --assembly
# COPY [".scala-build/", "/app/.scala-build/"]
WORKDIR /app
RUN scala-cli package App.scala -o app.jar --assembly

FROM openjdk:18-oraclelinux8
RUN mkdir /app
COPY --from=build /app/* /app
WORKDIR /app
EXPOSE 8080
ENV PORT=8080
CMD java -jar app.jar