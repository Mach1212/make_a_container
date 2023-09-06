FROM docker.io/library/rust:1.72 as compiler
RUN cargo install dioxus-cli --locked && rustup target add wasm32-unknown-unknown

WORKDIR /app
COPY hello_world_api .
RUN dx build --release

FROM docker.io/ubuntu/apache2:2.4-20.04_beta

WORKDIR /var/www/html/
COPY --from=compiler /app/dist .

EXPOSE 80


