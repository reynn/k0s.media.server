FROM alpine

RUN apk add --no-cache --update fish curl jq

COPY porkbun-dns.fish /porkbun-dns.fish

ENTRYPOINT ["fish", "-c", "/porkbun-dns.fish"]
