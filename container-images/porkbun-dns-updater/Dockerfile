FROM alpine

RUN apk add --no-cache --update fish httpie ca-certificates jq \
  && update-ca-certificates

COPY porkbun-dns.fish /porkbun-dns.fish

ENTRYPOINT ["fish", "-c", "/porkbun-dns.fish"]
