FROM rust:1-bullseye
WORKDIR /rust

COPY . .
RUN cargo build

ENTRYPOINT ["/porkbun-cli"]
