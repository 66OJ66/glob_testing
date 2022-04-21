#Load and prepare the base image
FROM rust:latest AS builder
WORKDIR /usr/src
RUN apt-get update && apt-get -y install musl-tools
RUN rustup target add x86_64-unknown-linux-musl

#Create a new empty project
RUN USER=root cargo new --bin gt
WORKDIR /usr/src/gt

#Compile the dependencies
COPY Cargo.toml ./
COPY Cargo.lock ./
RUN cargo build --target x86_64-unknown-linux-musl

#Build the exe (touch is used to force the 2nd build)
RUN rm src/*.rs
COPY src src
RUN touch -a -m ./src/main.rs
RUN cargo build --target x86_64-unknown-linux-musl
RUN strip ./target/x86_64-unknown-linux-musl/debug/glob_testing

#Create the final image
FROM scratch
COPY  --from=builder ./usr/src/gt/target/x86_64-unknown-linux-musl/debug/glob_testing glob_testing
COPY ./templates /templates
USER 1000
EXPOSE 8000
CMD ["/glob_testing"]