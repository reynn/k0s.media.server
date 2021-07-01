FROM rust:1-bullseye
WORKDIR /rust

COPY Cargo.toml .
RUN cargo fetch

COPY . .
RUN cargo build

ENTRYPOINT ["/porkbun-cli"]
