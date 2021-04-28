# K0s Media Server

Tiny media server for running on a minimal Kubernetes distro such as

- [K0s][homepage-k0s]
- [K3s][homepage-k3s]
- [KinD][homepage-kind]
- [MicroK8s][homepage-microk8s]
- Many others that I left out

## Bases

__Separated by Namespace__

| Name        | Role                | Homepage                               |
| ----------- | ------------------- | -------------------------------------- |
| calibre     | E-Book Management   | [calibre.io][homepage-calibre]         |
| sonarr      | TV/Anime Management | [sonarr.io][homepage-sonarr]           |
| radarr      | Movie Management    | [radarr.io][homepage-radarr]           |
| mylar       | Comic Management    | [mylar.io][homepage-mylar]             |
| lidarr      | Music Management    | [lidarr.io][homepage-lidarr]           |
| ----------- | ------------------- |                                        |
| jackett     | Torrent Aggregator  | [jackett.io][homepage-jackett]         |
| nzbget      | NZB Downloader      | [nzbget.io][homepage-nzbget]           |
| qbittorrent | Torrent Downloader  | [qbittorrent.io][homepage-qbittorrent] |
| ----------- | ------------------- |                                        |
| jellyfin    | Media Server/Player | [jellyfin.com][homepage-jellyfin]      |
| ----------- | ------------------- |                                        |
| longhorn    | K8s Storage Manager | [longhorn.io][homepage-longhorn]       |
| ----------- | ------------------- |                                        |
| nfs         | NFS File Share      | [nfs.io][homepage-nfs]                 |
| traefik     | Reverse Proxy       | [traefik.io][homepage-traefik]         |

### Base: Calibre

*Namespace:* `managers`

### Base: Jackett

*Namespace:* `downloaders`

### Base: Jellyfin

*Namespace:* `default`

### Base: Lidarr

*Namespace:* `managers`

### Base: Longhorn

*Namespace:* `longhorn-system`

### Base: Mylar

*Namespace:* `managers`

### Base: NZBGet

*Namespace:* `downloaders`

### Base: qBittorrent

*Namespace:* `downloaders`

### Base: Radarr

*Namespace:* `managers`

### Base: NFS

*Namespace:* `utils`

### Base: Sonarr

*Namespace:* `managers`

### Base: Traefik

*Namespace:* `utils`

<!-- -->

[homepage-calibre]: https://
[homepage-jackett]: https://
[homepage-jellyfin]: https://
[homepage-k0s]: https://k0s.io
[homepage-kind]: https://
[homepage-k3s]: https://k3s.io
[homepage-lidarr]: https://
[homepage-longhorn]: https://
[homepage-mylar]: https://
[homepage-nfs]: https://
[homepage-nzbget]: https://
[homepage-qbittorrent]: https://
[homepage-radarr]: https://
[homepage-sonarr]: https://
[homepage-traefik]: https://traefik.io/
[homepage-microk8s]: https://microk8s.io/
