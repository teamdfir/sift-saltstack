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
    "source": "https://sansorg.egnyte.com/dl/ha4z21OsPi/",
    "hash": "02f71ad97ece95e9bea61db31fe026b7b6c7e04a2a1f3257b51ace3153e88d59",
  },
  {
    "id": "poster-network-forensics",
    "filename": "Network-Forensics-Poster.pdf",
    "source": "https://sansorg.egnyte.com/dd/hZjkv5VupH/",
    "hash": "66ba6fb482b9f2c1ad9da5b8c379b1acff14dbd96bf6bf1046f39a4960e56b3c",
  },
  {
    "id": "poster-sift-remnux",
    "filename": "SIFT-REMnux-Poster.pdf",
    "source": "https://sansorg.egnyte.com/dd/OmJkv7itJB/",
    "hash": "5719b21c388d276984b5200f29561e093d02bc4dc2553889c4b8011f984fb0f0"
  },
  {
    "id": "poster-dfir-smartphone",
    "filename": "DFIR-Smartphone-Forensics-Poster.pdf",
    "source": "https://sansorg.egnyte.com/dd/70HVz2FsAd/",
    "hash": "6b2ba452137e2ef6572781f673817f4f15f3555a4b2f47b16629350f9990c1d3"
  },
  {
    "id": "poster-windows-forensics",
    "filename": "Windows-Forensics-Poster.pdf",
    "source": "https://sansorg.egnyte.com/dd/roVVbK72lU/",
    "hash": "a835554f0354cbddf98f333c8c860e43504adf45fadffadd8d4e6468ffcf8d2c"
  },
  {
    "id": "poster-ios-third-pary-apps",
    "filename": "iOS-3rd-Party-Apps-Poster.pdf",
    "source": "https://sansorg.egnyte.com/dd/z9N0iI9lb0/",
    "hash": "2f1b2b67a12d43de29014cce0097f4e58538b0bf9d9c48cedc4516b7b0aea78e"
  },
  {
    "id": "poster-zimmerman-tools",
    "filename": "Zimmerman-Tools-Poster.pdf",
    "source": "https://sansorg.egnyte.com/dd/l96Cpf39jx/",
    "hash": "8cbc02298b743217ffebd5887787d7bad7b4ea30715f9a74715aa31c41f8b7cc"
  },
  {
    "id": "poster-hunt-evil",
    "filename": "Hunt-Evil.pdf",
    "source": "https://sansorg.egnyte.com/dd/ylr96kbkB6/",
    "hash": "74fea603f50e389667a341c4d77ac6bd511f7b841d836edd640889b963ea0753"
  },
  {
    "id": "cheatsheet-sift",
    "filename": "SIFT-Cheatsheet.pdf",
    "source": "https://sansorg.egnyte.com/dd/rcC7AFiUr0/",
    "hash": "8fda96c8f7bc32844b843dd3d95e793316e23b765b440b240681d3bc9724ad5c"
  },
  {
    "id": "cheatsheet-windows-to-unix",
    "filename": "Windows-to-Unix-Cheatsheet.pdf",
    "source": "https://sansorg.egnyte.com/dd/OmZRZGy0uT/",
    "hash": "97be37ea175c0f53a808c45fcbeacd11889d77a566d2a01d421865bb4c352312"
  },
  {
    "id": "cheatsheet-hexfile-regex",
    "filename": "Hex-File-Regex-Cheatsheet.pdf",
    "source": "https://sansorg.egnyte.com/dd/ZvGHqvRS3X/",
    "hash": "d1a78b37886f524bc94e3e3aac8ab9816e904a6583f0145fd26c67524e23d032"
  },
  {
    "id": "cheatsheet-sqlite",
    "filename": "SQLite-Pocket-Reference.pdf",
    "source": "https://sansorg.egnyte.com/dd/KKxPl6LsbF/",
    "hash": "954d62787abe3bad95f59e2d671eac202dea2607ed5cdb757dbbb688b873f679"
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
