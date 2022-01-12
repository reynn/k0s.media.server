# K0s Media Server

Tiny media server for running on a minimal Kubernetes distro such as

- [K0s][homepage-k0s]
- [K3s][homepage-k3s]
- [KinD][homepage-kind]
- [MicroK8s][homepage-microk8s]
- Many others that I left outd

## Kustomize Plugins

[Helm Generator](https://github.com/joshrwolf/kustomize-helmgenerator)

## Bases

> __Separated by Namespace__

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
| OpenEBS     | K8s Storage Manager | [openebs.io][homepage-openebs]         |
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

### Base: OpenEBS

*Namespace:* `openebs`

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

[homepage-calibre]: https://calibre-ebook.com/
[homepage-jackett]: https://github.com/Jackett/Jackett
[homepage-jellyfin]: https://jellyfin.org/
[homepage-k0s]: https://k0sproject.io/
[homepage-kind]: https://kind.sigs.k8s.io/
[homepage-k3s]: https://k3s.io/
[homepage-microk8s]: https://microk8s.io/
[homepage-lidarr]: https://lidarr.audio/
[homepage-openebs]: https://openebs.io/
[homepage-mylar]: https://github.com/evilhero/mylar
[homepage-nfs]: https://en.wikipedia.org/wiki/Network_File_System
[homepage-nzbget]: https://nzbget.net/
[homepage-qbittorrent]: https://www.qbittorrent.org/
[homepage-radarr]: https://radarr.video/
[homepage-sonarr]: https://sonarr.tv/
[homepage-traefik]: https://traefik.io/
