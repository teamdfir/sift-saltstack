{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}

{%-
set pdfs = [
  {
    "id": "poster-threat-intelligence",
    "filename": "Poster_Threat-Intelligence-Consumption.pdf",
    "source": "https://www.sans.org/security-resources/posters/cyber-threat-intelligence-consumption/130/download",
    "hash": "02f71ad97ece95e9bea61db31fe026b7b6c7e04a2a1f3257b51ace3153e88d59",
  },
  {
    "id": "poster-network-forensics",
    "filename": "Network-Forensics-Poster.pdf",
    "source": "https://www.sans.org/security-resources/posters/network-forensics-poster/145/download",
    "hash": "66ba6fb482b9f2c1ad9da5b8c379b1acff14dbd96bf6bf1046f39a4960e56b3c",
  },
  {
    "id": "poster-sift-remnux",
    "filename": "SIFT-REMnux-Poster.pdf",
    "source": "https://www.sans.org/security-resources/posters/sift-remnux-poster/125/download",
    "hash": "5719b21c388d276984b5200f29561e093d02bc4dc2553889c4b8011f984fb0f0"
  },
  {
    "id": "poster-dfir-smartphone",
    "filename": "DFIR-Smartphone-Forensics-Poster.pdf",
    "source": "https://www.sans.org/security-resources/posters/dfir-advanced-smartphone-forensics/30/download",
    "hash": "6b2ba452137e2ef6572781f673817f4f15f3555a4b2f47b16629350f9990c1d3"
  },
  {
    "id": "poster-windows-forensics",
    "filename": "Windows-Forensics-Poster.pdf",
    "source": "https://www.sans.org/security-resources/posters/windows-forensic-analysis/170/download",
    "hash": "a835554f0354cbddf98f333c8c860e43504adf45fadffadd8d4e6468ffcf8d2c"
  },
  {
    "id": "poster-ios-third-pary-apps",
    "filename": "iOS-3rd-Party-Apps-Poster.pdf",
    "source": "https://www.sans.org/security-resources/posters/ios-third-party-apps-forensics-reference-guide-poster/300/download",
    "hash": "2f1b2b67a12d43de29014cce0097f4e58538b0bf9d9c48cedc4516b7b0aea78e"
  },
  {
    "id": "poster-zimmerman-tools",
    "filename": "Zimmerman-Tools-Poster.pdf",
    "source": "https://www.sans.org/security-resources/posters/eric-zimmermans-results-seconds-command-line-poster/195/download",
    "hash": "bc9072d1ef9c1a90c157ebc0b738c1cf2578f2453c255dd87161387f3025c2c7"
  },
  {
    "id": "poster-hunt-evil",
    "filename": "Hunt-Evil.pdf",
    "source": "https://www.sans.org/security-resources/posters/hunt-evil/165/download",
    "hash": "74fea603f50e389667a341c4d77ac6bd511f7b841d836edd640889b963ea0753"
  },
  {
    "id": "cheatsheet-sift",
    "filename": "SIFT-Cheatsheet.pdf",
    "source": "https://www.sans.org/security-resources/posters/sift-cheat-sheet/355/download",
    "hash": "5f437c02cf1fd3f456394af3d8131a5e362cc0356f929d5ba2cd5e909c4e419e"
  },
  {
    "id": "cheatsheet-windows-to-unix",
    "filename": "Windows-to-Unix-Cheatsheet.pdf",
    "source": "https://www.sans.org/security-resources/posters/windows-unix-cheat-sheet/370/download",
    "hash": "1f1e7f8f2d1c817be1c192fc6e76359df9b1f15986c4ac40d4595e0907f34d90"
  },
  {
    "id": "cheatsheet-hexfile-regex",
    "filename": "Hex-File-Regex-Cheatsheet.pdf",
    "source": "https://www.sans.org/security-resources/posters/hex-regex-forensics-cheat-sheet/345/download",
    "hash": "752eeae0236e15eb25498f2bc2e8a04367e300317e71ee3a77630a5b3f8e28f8"
  },
  {
    "id": "cheatsheet-sqlite",
    "filename": "SQLite-Pocket-Reference.pdf",
    "source": "https://www.sans.org/security-resources/posters/sqlite-pocket-reference-guide/380/download",
    "hash": "0578faaba49700d9d7fe3d309366d5a662486adfcf87dc8083d698549c901ceb"
  },
]
-%}

include:
  - sift.config.user.user

{% for pdf in pdfs %}
sift-pdf-{{ pdf.id }}:
  file.managed:
    - name: {{ home }}/Desktop/{{ pdf.filename }}
    - source: {{ pdf.source }}
    - source_hash: sha256={{ pdf.hash }}
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True
    - show_changes: False
    - require:
      - user: sift-user-{{ user }}
{% endfor %}
